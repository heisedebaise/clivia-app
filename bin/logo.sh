#!/bin/bash

# dnf install -y ImageMagick

convert images/logo.png -resize 48x48 android/app/src/main/res/mipmap-mdpi/ic_launcher.png
convert images/logo.png -resize 72x72 android/app/src/main/res/mipmap-hdpi/ic_launcher.png
convert images/logo.png -resize 96x96 android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
convert images/logo.png -resize 144x144 android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
convert images/logo.png -resize 192x192 android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png

convert images/logo.png -resize 20x20 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png
convert images/logo.png -resize 40x40 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png
convert images/logo.png -resize 60x60 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png
convert images/logo.png -resize 29x29 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png
convert images/logo.png -resize 58x58 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png
convert images/logo.png -resize 87x87 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png
convert images/logo.png -resize 40x40 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png
convert images/logo.png -resize 80x80 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png
convert images/logo.png -resize 120x120 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png
convert images/logo.png -resize 120x120 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png
convert images/logo.png -resize 180x180 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png
convert images/logo.png -resize 76x76 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png
convert images/logo.png -resize 152x152 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png
convert images/logo.png -resize 167x167 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png
convert images/logo.png -resize 1024x1024 ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png

convert images/logo.png -resize 256x256 windows/runner/resources/app_icon.ico

convert images/logo.png -resize 16x16 macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_16.png
convert images/logo.png -resize 32x32 macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_32.png
convert images/logo.png -resize 64x64 macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_64.png
convert images/logo.png -resize 128x128 macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_128.png
convert images/logo.png -resize 256x256 macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_256.png
convert images/logo.png -resize 512x512 macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_512.png
convert images/logo.png -resize 1024x1024 macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_1024.png

convert images/logo.png -resize 16x16 web/favicon.png
convert images/logo.png -resize 192x192 web/icons/Icon-192.png
convert images/logo.png -resize 512x512 web/icons/Icon-512.png
convert images/logo.png -resize 192x192 web/icons/Icon-maskable-192.png
convert images/logo.png -resize 512x512 web/icons/Icon-maskable-512.png