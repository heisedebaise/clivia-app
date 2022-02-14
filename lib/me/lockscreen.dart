import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../components/password.dart';
import '../context.dart';
import '../generated/l10n.dart';
import '../util/router.dart';

const String _levelKey = 'settings.lock-screen.level';
const String _key = 'settings.lock-screen';

class LockScreen extends StatefulWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  @override
  Widget build(BuildContext context) => SwitchListTile(
    title: Text(S.of(context).meSettingsLockScreen),
    value: Context.get(_key, defaultValue: '') != '',
    onChanged: (bool on) async {
      PageRouter.push(
        context,
        PasswordPage(
          on ? S.of(context).meSettingsLockScreenOn : S.of(context).meSettingsLockScreenOff,
          _levelKey,
          full: true,
          twice: on,
          complete: (value) async {
            value = ScreenLocker._digest(value);
            if (on) {
              await Context.set(_key, value);
              setState(() {});

              return Future.value(null);
            }

            if (value == Context.get(_key)) {
              await Context.remove(_key);
              setState(() {});

              return Future.value(null);
            }

            return Future.value(S.of(context).meSettingsLockScreenFailure);
          },
        ),
      );
    },
  );
}

class ScreenLocker {
  static bool _on = false;
  static bool _off = false;

  static void off(bool off) {
    _off = off;
  }

  static void show(BuildContext context) {
    if (_on || _off || Context.get(_key, defaultValue: '') == '') return;

    _on = true;
    PageRouter.push(
      context,
      PasswordPage(
        S.of(context).meSettingsLockScreenPassword,
        _levelKey,
        popable: false,
        full: true,
        complete: (value) async {
          if (_digest(value) == Context.get(_key)) {
            _on = false;

            return Future.value(null);
          }

          return Future.value(S.of(context).meSettingsLockScreenFailure);
        },
      ),
    );
  }

  static String _digest(String string) {
    string = sha1.convert(utf8.encode(_levelKey + string)).toString();

    return sha1.convert(utf8.encode(string + _key)).toString();
  }
}
