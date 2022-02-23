import 'package:flutter/material.dart';

import '../components/password.dart';
import '../generated/l10n.dart';
import '../user.dart';
import '../util/router.dart';

const String _levelKey = 'settings.lock-screen.level';

class LockScreen extends StatefulWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  @override
  Widget build(BuildContext context) => SwitchListTile(
        title: Text(S.of(context).meSettingsLockScreen),
        value: User.screen(),
        onChanged: (bool on) async {
          PageRouter.push(
            context,
            PasswordPage(
              on ? S.of(context).meSettingsLockScreenOn : S.of(context).meSettingsLockScreenOff,
              _levelKey,
              full: true,
              twice: on,
              complete: (value) async {
                return await User.passwordOnOff(context, on, 'screen', value, setState, S.of(context).meSettingsLockScreenWrong);
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
    if (_on || _off || !User.screen()) return;

    _on = true;
    PageRouter.push(
      context,
      PasswordPage(
        S.of(context).meSettingsLockScreenPassword,
        _levelKey,
        popable: false,
        full: true,
        complete: (value) async {
          if (await User.passwordAuth('screen', value)) {
            _on = false;

            return Future.value(null);
          }

          return Future.value(S.of(context).meSettingsLockScreenWrong);
        },
      ),
    );
  }
}
