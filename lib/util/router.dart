import 'package:flutter/material.dart';

class PageRouter {
  static Future<T?> push<T>(BuildContext context, Widget widget) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
}
