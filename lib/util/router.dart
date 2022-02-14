import 'package:flutter/material.dart';

import '../context.dart';

class PageRouter {
  static Future<T?> push<T>(BuildContext? context, Widget widget) {
    context ??= Context.navigatorKey.currentContext;

    return Navigator.of(context!).push(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static void pop(BuildContext? context) {
    Navigator.of(context ?? Context.navigatorKey.currentContext!).pop();
  }
}
