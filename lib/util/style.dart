import 'package:flutter/material.dart';

// https://fonts.google.com/icons?selected=Material+Icons

class Style {
  static TextStyle? body(BuildContext context) => Theme.of(context).textTheme.bodyText1;

  static TextStyle? tileTitle(BuildContext context) => Theme.of(context).textTheme.subtitle1;

  static TextStyle? tileSubtitle(ThemeData theme) => theme.textTheme.bodyText2!.copyWith(color: theme.textTheme.caption!.color);

  static Color? tileIcon(BuildContext context) => Theme.of(context).brightness == Brightness.light ? Colors.black45 : null;
}
