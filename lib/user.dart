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
    m['user.gesture'] = map['gesture'];
    await Context.sets(m);

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
      Map<String, dynamic> m = {};
      m['user.id'] = map['id'];
      m['user.gesture'] = map['gesture'];
      m['user.destroy'] = map['destroy'];
      await Context.sets(m);
    }

    return Future.value(null);
  }

  static Future<void> signOut() async {
    await Http.service('/user/sign-out');
    _map = {};

    return Future.value(null);
  }

  static String username() => Context.get('user.uid', defaultValue: '');

  static bool on() => _map.containsKey('code');

  static String avatar(String empty) => get('avatar', empty);

  static String nick(String empty) => get('nick', empty);

  static bool gesture() => Context.get('user.gesture', defaultValue: false);

  static bool destroy() => Context.get('user.destroy', defaultValue: false);

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
