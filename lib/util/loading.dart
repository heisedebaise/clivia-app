import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loading {
  static void show({String? message}) => EasyLoading.show(
        status: message,
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );

  static void hide() => EasyLoading.dismiss();
}
