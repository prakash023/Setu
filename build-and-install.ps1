
param(
    [Parameter(Mandatory = $true)]
    [string]$TvAddress,

    [switch]$SetAsHome
)

$ErrorActionPreference = 'Stop'

$Package = 'com.prakash023.nepalilauncher'
$Apk = Join-Path $PSScriptRoot 'app\build\outputs\apk\debug\app-debug.apk'

# Find Java / JDK
if (-not $env:JAVA_HOME -or
    -not (Test-Path "$env:JAVA_HOME\bin\java.exe")) {

    $candidates = @(
        'C:\Program Files\Eclipse Adoptium\jdk-21.0.12.101-hotspot',
        'C:\Program Files\Android\Android Studio\jbr'
    )

    $jdk = $candidates |
        Where-Object { Test-Path "$_\bin\java.exe" } |
        Select-Object -First 1

    if (-not $jdk) {
        throw 'Install JDK 17+ and set JAVA_HOME before building Setu.'
    }

    $env:JAVA_HOME = $jdk
}

$env:Path = "$env:JAVA_HOME\bin;$env:Path"

# Find Android SDK and ADB
$sdk = if ($env:ANDROID_HOME) {
    $env:ANDROID_HOME
} else {
    Join-Path $env:LOCALAPPDATA 'Android\Sdk'
}

$adb = Join-Path $sdk 'platform-tools\adb.exe'

if (-not (Test-Path $adb)) {
    throw "ADB not found at $adb. Install Android SDK Platform Tools."
}

if (-not (Test-Path (Join-Path $sdk 'platforms'))) {
    throw "Android SDK platforms not found at $sdk. Install the required Android SDK platform."
}

# Create local.properties if missing
$localProperties = Join-Path $PSScriptRoot 'local.properties'

if (-not (Test-Path $localProperties)) {
    $escapedSdk = $sdk -replace '\\', '\\'
    "sdk.dir=$escapedSdk" |
        Set-Content -Path $localProperties -Encoding ASCII
}

# Connect to the specified TV
Write-Host "Connecting to TV at $TvAddress ..."
& $adb connect $TvAddress

if ($LASTEXITCODE -ne 0) {
    throw 'ADB could not connect to the TV.'
}

# Build Setu
Push-Location $PSScriptRoot
try {
    & .\gradlew.bat assembleDebug

    if ($LASTEXITCODE -ne 0) {
        throw 'Setu APK build failed.'
    }
}
finally {
    Pop-Location
}

if (-not (Test-Path $Apk)) {
    throw "APK not found: $Apk"
}

# Install Setu without disabling the stock launcher
Write-Host 'Installing Setu...'
& $adb -s $TvAddress install -r $Apk

if ($LASTEXITCODE -ne 0) {
    throw 'Setu installation failed.'
}

if ($SetAsHome) {
    Write-Host 'Setting Setu as the Home launcher...'
    & $adb -s $TvAddress shell cmd package set-home-activity --user 0 $Package

    if ($LASTEXITCODE -ne 0) {
        throw 'Setu installed, but setting it as Home failed.'
    }
}

Write-Host ''
Write-Host 'Setu installation completed successfully.' -ForegroundColor Green

if (-not $SetAsHome) {
    Write-Host 'Setu is installed. Choose it as your Home app on the TV if desired.'
}
