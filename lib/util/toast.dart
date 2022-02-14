import 'package:flutter_easyloading/flutter_easyloading.dart';

class Toast {
  static void success(String message) => EasyLoading.showSuccess(message);

  static void info(String message) => EasyLoading.showInfo(message);

  static void error(int code, String message) => EasyLoading.showError(code > 0 ? '[$code] $message' : message);
}
