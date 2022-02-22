import 'package:flutter/material.dart';

import '../../components/password.dart';
import '../../generated/l10n.dart';
import '../../user.dart';
import '../../util/http.dart';
import '../../util/router.dart';

class DestroyPassword extends StatefulWidget {
  const DestroyPassword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DestroyPasswordState();
}

class _DestroyPasswordState extends State<DestroyPassword> {
  @override
  Widget build(BuildContext context) => SwitchListTile(
        title: Text(S.of(context).meSignDestroy),
        subtitle: Text(S.of(context).meSignDestroyMemo),
        value: User.destroy(),
        onChanged: (bool on) {
          PageRouter.push(
            context,
            PasswordPage(
              on ? S.of(context).meSignDestroyOn : S.of(context).meSignDestroyOff,
              'user.sign-in.destroy',
              twice: on,
              full: true,
              complete: (value) async {
                if (on) {
                  Map<String, dynamic>? map = await Http.post('/user/destroy', data: {'old': '', 'new': value, 'repeat': value});
                  if (map == null || !map.containsKey('code')) {
                    return Future.value(S.of(context).httpFailure);
                  }

                  if (map['code'] > 0) return Future.value(map['message']);

                  await User.sign();
                  setState(() {});

                  return Future.value(null);
                }

                Map<String, dynamic>? map = await Http.post('/user/destroy-off', data: {'destroy': value});
                if (map == null || !map.containsKey('code')) {
                  return Future.value(S.of(context).httpFailure);
                }

                if (map['code'] > 0) return Future.value(map['message']);

                await User.sign();
                setState(() {});

                return Future.value(null);
              },
            ),
          );
        },
      );
}

class Destroy extends StatelessWidget {
  const Destroy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(S.of(context).meSignDestroyAccount),
        subtitle: Text(S.of(context).meSignDestroyAccountMemo),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(S.of(context).meSignDestroyAccount),
              content: Text(S.of(context).meSignDestroyAccountMemo),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(S.of(context).cancel)),
                TextButton(
                    onPressed: () {
                      PageRouter.push(
                        context,
                        PasswordPage(
                          S.of(context).meSignDestroyPassword,
                          'user.sign-in.destroy.password',
                          twice: false,
                          full: true,
                          complete: (value) async {
                            print(value);

                            return Future.value('password err');
                          },
                        ),
                      );
                    },
                    child: Text(
                      S.of(context).ok,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    )),
              ],
            ),
          );
        },
      );
}
