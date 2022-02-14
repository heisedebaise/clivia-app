import 'dart:convert';

import 'package:flutter/material.dart';

import 'generated/l10n.dart';
import 'util/io.dart';

class Context {
  static Map<String, dynamic> _map = {};

  static Future<void> init() async {
    String? string = await Io.readAsString('/context');
    if (string == null) return;

    _map = json.decode(string);
  }

  static ThemeData theme() {
    String theme = get('theme', defaultValue: '');

    return theme == 'dark' ? ThemeData.dark() : ThemeData.light();
  }

  static Locale? locale() => localeCallback(WidgetsBinding.instance!.window.locales, S.delegate.supportedLocales);

  static Locale? localeCallback(List<Locale>? locales, Iterable<Locale>? supportedLocales) {
    String? language = get('language');

    return language == null ? supportedLocales?.first : Locale.fromSubtags(languageCode: language);
  }

  static dynamic get(String key, {dynamic defaultValue}) => _map.containsKey(key) ? _map[key] : defaultValue;

  static Future<void> set(String key, dynamic value) async {
    _map[key] = value;
    await _write();
  }

  static Future<void> sets(Map<String, dynamic> map) async {
    if (map.isEmpty) return;

    _map.addAll(map);
    await _write();
  }

  static Future<dynamic> remove(String key) async {
    dynamic value = _map.remove(key);
    await _write();

    return value;
  }

  static Future<void> _write() async => await Io.writeString('/context', json.encode(_map));
}
