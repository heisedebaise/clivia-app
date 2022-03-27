import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';
import 'util/io.dart';

class Context {
  static final bool mobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static bool active = true;
  static Map<String, dynamic> _map = {};
  static final Map<String, dynamic> _memory = {};
  static SharedPreferences? _sharedPreferences;
  static Orientation? _orientation;

  static Future<void> init() async {
    if (kIsWeb) {
      _sharedPreferences = await SharedPreferences.getInstance();

      return;
    }

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
    return '192.168.31.169';
  }

  static dynamic get(String key, {dynamic defaultValue, bool memory = false}) {
    if (kIsWeb) {
      if (memory) {
        return _memory.containsKey(key) ? _memory[key] : defaultValue;
      }

      return _getSharedPreferences(key) ?? defaultValue;
    }

    Map m = memory ? _memory : _map;

    return m.containsKey(key) ? m[key] : defaultValue;
  }

  static bool has(String key, dynamic value, {bool memory = false}) {
    if (kIsWeb) {
      if (memory) {
        return _memory.containsKey(key) && _memory[key] == value;
      }

      return _getSharedPreferences(key) == value;
    }

    Map m = memory ? _memory : _map;

    return m.containsKey(key) && m[key] == value;
  }

  static Future<void> set(String key, dynamic value, {bool memory = false}) async {
    if (memory) {
      _memory[key] = value;

      return;
    }

    if (kIsWeb) {
      _sharedPreferences?.setString(key, json.encode({'value': value}));

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

    if (kIsWeb) {
      map.forEach((key, value) => _sharedPreferences?.setString(key, json.encode({'value': value})));

      return;
    }

    _map.addAll(map);
    await _write();
  }

  static Future<dynamic> remove(String key, {bool memory = false}) async {
    if (memory) return _memory.remove(key);

    if (kIsWeb) {
      dynamic value = _getSharedPreferences(key);
      await _sharedPreferences?.remove(key);

      return value;
    }

    dynamic value = _map.remove(key);
    await _write();

    return value;
  }

  static dynamic _getSharedPreferences(String key) {
    String? string = _sharedPreferences?.getString(key);
    if (string == null) return null;

    Map? map = json.decode(string);
    if (map == null || !map.containsKey('value')) return null;

    return map['value'];
  }

  static void orientation(Orientation orientation) {
    _orientation = _orientation;
  }

  static bool landscape() => _orientation == Orientation.landscape;

  static Future<void> _write() async => await Io.writeString('context', json.encode(_map));
}
