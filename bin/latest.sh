#!/bin/bash

dependencies=(
 crypto
 path_provider
 provider
 dio
 flutter_easyloading
 image
 extended_image
 image_picker
 file_picker
 url_launcher
 qr_flutter
 qr_code_scanner
 badges
 webview_flutter
 gesture_password_widget
)

for i in `seq 0 $[${#dependencies[*]}-1]`; do
  flutter pub remove ${dependencies[i]}
done

for i in `seq 0 $[${#dependencies[*]}-1]`; do
  flutter pub add ${dependencies[i]}
done

flutter pub get