import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'generated/l10n.dart';
import 'util/io.dart';

class Context {
  static final bool mobile = Platform.isAndroid || Platform.isIOS;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static bool active = true;
  static Map<String, dynamic> _map = {};
  static final Map<String, dynamic> _memory = {};
  static Orientation? _orientation;

  static Future<void> init() async {
    String? string = await Io.readAsString('context');
    if (string == null) return;

    _map = json.decode(string);
  }

  static ThemeData theme() {
    String theme = get('theme', defaultValue: '');
    if (theme == '' && SchedulerBinding.instance!.window.platformBrightness == Brightness.dark) {
      theme = 'dark';
    }

    return theme == 'dark' ? ThemeData.dark() : ThemeData.light();
  }

  static Locale? locale() => localeCallback(WidgetsBinding.instance!.window.locales, S.delegate.supportedLocales);

  static Locale? localeCallback(List<Locale>? locales, Iterable<Locale>? supportedLocales) {
    String? language = get('language');

    return language == null ? supportedLocales?.first : Locale.fromSubtags(languageCode: language);
  }

  static String host() {
    return '192.168.20.127';
  }

  static dynamic get(String key, {dynamic defaultValue, bool memory = false}) {
    Map m = memory ? _memory : _map;

    return m.containsKey(key) ? m[key] : defaultValue;
  }

  static bool has(String key, dynamic value, {bool memory = false}) {
    Map m = memory ? _memory : _map;

    return m.containsKey(key) && m[key] == value;
  }

  static Future<void> set(String key, dynamic value, {bool memory = false}) async {
    if (memory) {
      _memory[key] = value;

      return;
    }

    _map[key] = value;
    await _write();
  }

  static Future<void> sets(Map<String, dynamic> map, {bool memory = false}) async {
    if (map.isEmpty) return;

    if (memory) {
      _memory.addAll(map);

      return;
    }

    _map.addAll(map);
    await _write();
  }

  static Future<dynamic> remove(String key, {bool memory = false}) async {
    if (memory) return _memory.remove(key);

    dynamic value = _map.remove(key);
    await _write();

    return value;
  }

  static void orientation(Orientation orientation) {
    _orientation = _orientation;
  }

  static bool landscape() => _orientation == Orientation.landscape;

  static Future<void> _write() async => await Io.writeString('context', json.encode(_map));
}
