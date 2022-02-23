import 'package:flutter/material.dart';

import 'context.dart';
import 'generated/l10n.dart';
import 'util/http.dart';

class User {
  static bool anonymous = true;
  static Map<String, dynamic> _map = {};
  static final List<String> _modifies = [
    'idcard',
    'name',
    'nick',
    'mobile',
    'email',
    'weixin',
    'qq',
    'avatar',
    'gender',
    'birthday',
  ];

  static Future<bool> signUp(
    BuildContext context,
    String username,
    String password,
    String nick,
  ) async {
    return _sign(context, '/user/sign-up', {
      'type': '',
      'uid': username,
      'password': password,
      'nick': nick,
    });
  }

  static Future<bool> signIn(
    BuildContext context,
    String username,
    String password,
  ) async {
    return _sign(context, '/user/sign-in', {
      'type': '',
      'uid': username,
      'password': password,
    });
  }

  static Future<bool> _sign(
    BuildContext context,
    String uri,
    Map<String, String> body,
  ) async {
    Map<String, dynamic>? map = await Http.service(
      uri,
      data: body,
      message: true,
      context: context,
    );
    if (map == null) return Future.value(false);

    _map = map;

    Map<String, dynamic> m = {};
    if (body.containsKey('uid')) m['user.uid'] = body['uid'];
    m['user.id'] = map['id'];
    await Context.sets(m);
    await _password();

    return Future.value(true);
  }

  static Future<String?> signInGesture(BuildContext context, String gesture) async {
    Map<String, dynamic>? map = await Http.post('/user/sign-in-gesture', data: {'id': Context.get('user.id', defaultValue: ''), 'gesture': gesture});
    if (map == null || !map.containsKey('code')) return Future.value(S.of(context).httpFailure);

    if (map['code'] > 0) return Future.value(map['message']);

    await sign();

    return Future.value(null);
  }

  static Future<void> sign() async {
    Map<String, dynamic>? map = await Http.service('/user/sign');
    if (map != null && map.containsKey('id')) {
      _map = map;
      await Context.set('user.id', map['id']);
      await _password();
    }

    return Future.value(null);
  }

  static Future<void> _password() async {
    Map<String, dynamic>? map = await Http.service('/user/password/has');
    if (map == null) return;

    await Context.sets({
      'user.screen': map['screen'] ?? 0,
      'user.gesture': map['gesture'] ?? 0,
      'user.destroy': map['destroy'] ?? 0,
    });
  }

  static Future<bool> passwordAuth(String type, String password) async {
    dynamic data = await Http.service('/user/password/auth', data: {
      'type': type,
      'password': password,
    });

    return data != null && data;
  }

  static Future<String> passwordSet(BuildContext context, String type, String password, [bool unique = false]) async {
    String? data = await Http.service('/user/password/set', data: {
      'type': type,
      'new': password,
      'old': '',
      'unique': unique,
    });

    switch (data) {
      case '':
        return '';
      case 'gesture':
        return S.of(context).meSignGestureSame;
      case 'destroy':
        return S.of(context).meSignDestroySame;
      default:
        return S.of(context).failure;
    }
  }

  static Future<bool> passwordOff(String type, String password) async {
    dynamic data = await Http.service('/user/password/off', data: {
      'type': type,
      'password': password,
    });

    return data != null && data;
  }

  static Future<void> signOut() async {
    await Http.service('/user/sign-out');
    _map = {};

    return Future.value(null);
  }

  static Future<dynamic> passwordOnOff(
    BuildContext context,
    bool on,
    String type,
    String password,
    void Function(void Function()) setState,
    String wrong,
  ) async {
    if (on) {
      String set = await passwordSet(context, type, password);
      if (set != '') return Future.value(set);

      await User.sign();
      setState(() {});

      return Future.value(null);
    }

    bool off = await User.passwordOff(type, password);
    if (!off) return Future.value(wrong);

    await User.sign();
    setState(() {});

    return Future.value(null);
  }

  static String username() => Context.get('user.uid', defaultValue: '');

  static bool on() => _map.containsKey('code');

  static String avatar(String empty) => get('avatar', empty);

  static String nick(String empty) => get('nick', empty);

  static bool screen() => Context.get('user.screen', defaultValue: 0) > 0;

  static bool gesture() => Context.get('user.gesture', defaultValue: 0) > 0;

  static bool destroy() => Context.get('user.destroy', defaultValue: 0) > 0;

  static String code(String empty) => get('code', empty);

  static dynamic get(String key, dynamic empty) {
    dynamic value = _map.containsKey(key) ? _map[key] : null;

    return value == null || value == '' ? empty : value;
  }

  static Future<bool> modify(BuildContext context, Map<String, String> map) {
    Map<String, String> body = {};
    for (var name in _modifies) {
      if (_map.containsKey(name)) body[name] = _map[name].toString();
    }
    body.addAll(map);

    return _sign(context, '/user/modify', body);
  }
}
