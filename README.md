\# Setu — Android TV Launcher



Setu is a personalized Android TV launcher based on the open-source \[CleanYourTV](https://github.com/Gathin23/cleanyourtv) project by Gathin23.



Setu aims to provide a clean, modern, and personalized home-screen experience for Android TV devices.



\## Features



\- Personalized Android TV home screen

\- Custom launcher identity and interface

\- App grid and dock configuration

\- Custom Namaste branding and Nepali-inspired design

\- Personalized clock and calendar

\- Configurable list of pinned and hidden applications



Features may change as development continues.



\## TV Home Screen



!\[Setu TV Home Screen](app/screenshot/setu-home.jpg)



\## Requirements



To build Setu on Windows, you need:



\- Windows 10 or Windows 11

\- Git

\- Java JDK 17 or newer (JDK 21 is recommended)

\- Android SDK and the Android SDK platform required by the project

\- Android SDK Platform Tools, including `adb.exe`

\- An Android TV device or compatible streaming device

\- ADB debugging enabled on the TV to install over the network



Android Studio can provide the JDK and Android SDK components.



\## Download Setu



Clone the repository:



```powershell

git clone https://github.com/prakash023/Setu.git

cd Setu

```



Alternatively, select \*\*Code → Download ZIP\*\* on GitHub and extract the project.



\## Build the APK on Windows



Open PowerShell in the Setu project folder.



\### 1. Configure Java



Make sure a compatible JDK is installed and `JAVA\_HOME` points to it.



For example, if JDK 21 is installed at the following path:



```powershell

$env:JAVA\_HOME = "C:\\Program Files\\Eclipse Adoptium\\jdk-21.0.12.101-hotspot"

$env:Path = "$env:JAVA\_HOME\\bin;$env:Path"

java -version

```



Use your actual JDK installation path if it is different.



\### 2. Configure the Android SDK



If the SDK is installed in the default Windows location:



```powershell

$env:ANDROID\_HOME = "$env:LOCALAPPDATA\\Android\\Sdk"

```



Ensure the required Android SDK platform and build tools are installed.



\### 3. Build Setu



Run:



```powershell

.\\gradlew.bat assembleDebug

```



When the build succeeds, the APK will be generated at:



```text

app/build/outputs/apk/debug/app-debug.apk

```



\## Install Setu on Android TV



\### 1. Enable debugging



On your TV, enable Developer Options and network debugging. The exact menu names depend on the device and Android version.



Connect your computer and TV to the appropriate network and find the TV's ADB IP address and port.



\### 2. Connect to the TV



Make sure Android SDK Platform Tools are installed, then run:



```powershell

adb connect TV\_IP\_ADDRESS:PORT

adb devices

```



Replace `TV\_IP\_ADDRESS:PORT` with the address shown by your TV. Some devices use a different pairing and connection process.



\### 3. Install Setu



From the Setu project directory, run:



```powershell

.\\build-and-install.ps1 -TvAddress "TV\_IP\_ADDRESS:PORT"

```



This script builds the APK and installs Setu on the specified device. It does not automatically disable the stock launcher.



To request that Setu be configured as the Home launcher, use:



```powershell

.\\build-and-install.ps1 -TvAddress "TV\_IP\_ADDRESS:PORT" -SetAsHome

```



Launcher switching depends on the TV's Android version and manufacturer restrictions. Keep the stock launcher available until you have confirmed that Setu works correctly.



\## Install an Existing APK



If a prebuilt APK is available from a GitHub Release, download it instead of building from source.



Then connect to the TV and install it:



```powershell

adb connect TV\_IP\_ADDRESS:PORT

adb -s TV\_IP\_ADDRESS:PORT install -r Setu.apk

```



Replace `Setu.apk` with the actual downloaded APK filename.



\*\*Note:\*\* A prebuilt APK is available only when a release has been published. Check the repository's Releases section for available downloads.



\## Troubleshooting



\### Java or JDK errors



Check the Java installation:



```powershell

java -version

$env:JAVA\_HOME

```



Make sure `JAVA\_HOME` points to a JDK installation, not a JRE-only directory.



\### Android SDK errors



Check that the Android SDK is installed and that the required platform is available. Set `ANDROID\_HOME` if your SDK is installed in a non-default location.



\### ADB is not recognized



Run ADB using its full path if it is not on your `PATH`:



```powershell

\& "$env:LOCALAPPDATA\\Android\\Sdk\\platform-tools\\adb.exe" devices

```



\### TV connection fails



\- Confirm that network debugging is enabled.

\- Check the TV's current IP address and port.

\- Complete ADB pairing if the device requires it.

\- Ensure the computer and TV can communicate over the network.



\### Installation fails



Confirm that the APK built successfully, that the TV is connected, and that the device allows installation of the package.



\## Technology



\- Platform: Android TV

\- UI: Android layouts and drawable resources

\- Language: Java

\- Build system: Gradle

\- Version control: Git and GitHub

\- Package ID: `com.prakash023.nepalilauncher`



\## Project Origin and Credits



Setu is a customized project based on \[CleanYourTV](https://github.com/Gathin23/cleanyourtv), created by Gathin23.



I acknowledge and thank the original creator for making the project available. Setu is maintained in a separate repository, and its customizations are developed for my own launcher experience.



The original project's code and assets remain subject to their respective licenses and attribution requirements. Please review the upstream repository's license and the licenses of any third-party assets before redistributing the project.



\## Development Status



Setu is an ongoing personal project. The interface and features may evolve as development continues.



Future improvements may include additional media integrations and further launcher customization.



\## Repository



\[https://github.com/prakash023/Setu](https://github.com/prakash023/Setu)
