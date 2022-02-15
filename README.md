# clivia

## install

```
# fedora
dnf install -y clang cmake ninja-build pkg-config gtk3-devel

# windows 10
install Visual Studio 2019 ->「使用 C++ 的桌面开发」

# macos
```

## create

```
flutter config --enable-windows-desktop
flutter config --enable-macos-desktop
flutter config --enable-linux-desktop

flutter create --org org.lpw.clivia clivia
```

```
# Tools > Flutter Intel > Initialize
dependencies:
  flutter_localizations:
    sdk: flutter
```

## android

```
# android/app/build.gradle
minSdkVersion 20

# android/build.gradle
ext.kotlin_version = '1.6.10'
classpath 'com.android.tools.build:gradle:4.2.2'

# android/gradle/wrapper/gradle-wrapper.properties
distributionUrl=https\://services.gradle.org/distributions/gradle-7.4-all.zip
```

## ios

```
cp ios/Runner/Info.plist ios/Runner/Info-Debug.plist
cp ios/Runner/Info.plist ios/Runner/Info-Profile.plist
cp ios/Runner/Info.plist ios/Runner/Info-Release.plist

# xcode: Add Files to "Runner"
# xcode: Runner->TARGETS->Runner->Build Settings->Packaging->Info.plist File->Runner/Info-$(CONFIGURATION).plist
```

```
debug for 14+: ios/Runner/Info-Debug.plist
NSBonjourServices: _dartobservatory._tcp
```

```
# image_picker: ios/Runner/Info-*.plist
NSPhotoLibraryUsageDescription
NSCameraUsageDescription
NSMicrophoneUsageDescription
```

## other

```
# pdfx
flutter pub run pdfx:install_web
flutter pub run pdfx:install_windows
```