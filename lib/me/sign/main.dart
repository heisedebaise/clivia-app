import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../components/avatar.dart';
import '../../components/password.dart';
import '../../components/picture.dart';
import '../../components/popage.dart';
import '../../components/qrcode.dart';
import '../../generated/l10n.dart';
import '../../user.dart';
import '../../util/http.dart';
import '../../util/obscure.dart';
import '../../util/router.dart';
import 'change.dart';
import 'inup.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final Divider divider = const Divider(height: 1);

  @override
  Widget build(BuildContext context) => PopPage(
        title: S.of(context).meSignInfo,
        body: ListView(
          children: [
            item(
              S.of(context).meSignAvatar,
              Avatar(uri: User.avatar(''), nick: User.nick(''), size: 32),
              0,
            ),
            divider,
            item(
              S.of(context).meSignNick,
              Text(User.nick(S.of(context).meSignNickEmpty)),
              1,
            ),
            divider,
            gesture(),
            divider,
            item(
              S.of(context).meSignMobile,
              Text(Obscure.mobile(User.get('mobile', S.of(context).unset))),
              2,
            ),
            divider,
            item(
              S.of(context).meSignEmail,
              Text(Obscure.email(User.get('email', S.of(context).unset))),
              3,
            ),
            divider,
            item(
              S.of(context).meSignQrCode,
              const Icon(Icons.qr_code_2),
              4,
            ),
            divider,
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await User.signOut();
                    if (User.anonymous) {
                      Navigator.pop(context);
                    } else {
                      await PageRouter.push(context, const InUpPage());
                      Navigator.pop(context);
                    }
                  },
                  child: Text(S.of(context).meSignOut),
                ),
              ),
            ),
          ],
        ),
      );

  Widget item(String label, Widget value, int index) => ListTile(
        title: Row(
          children: [
            Expanded(child: Text(label)),
            value,
          ],
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () async {
          if (index == 4) {
            QrCode.show(context, 'clivia:user:${User.code('')}',
                image: ExtendedNetworkImageProvider(
                  Http.url(User.avatar('')),
                  cache: true,
                ));

            return;
          }

          dynamic back = await PageRouter.push(context, page(index));
          if (back != null && back) setState(() {});
        },
      );

  Widget page(int index) {
    if (index == 1) {
      return ChangePage(
        S.of(context).meSignNickChange,
        Icons.face_retouching_natural,
        'nick',
        S.of(context).meSignNickChangeMemo,
      );
    }

    if (index == 2) {
      return ChangePage(
        S.of(context).meSignMobileChange,
        Icons.phone,
        'mobile',
        '',
      );
    }

    if (index == 3) {
      return ChangePage(
        S.of(context).meSignEmailChange,
        Icons.email,
        'email',
        '',
      );
    }

    return PicturePage(S.of(context).meSignAvatarChange, 'clivia.user.avatar', uri: User.avatar(''), ratio: 1, ok: (uri) async {
      await User.modify(context, {'avatar': uri});
      setState(() {});
    });
  }

  Widget gesture() => SwitchListTile(
      title: Text(S.of(context).meSignGesture),
      value: User.gesture(),
      onChanged: (bool on) {
        PageRouter.push(
            context,
            PasswordPage(
              on ? S.of(context).meSignGestureOn : S.of(context).meSignGestureOff,
              'user.sign-in.gesture',
              twice: on,
              complete: (value) async {
                if (on) {
                  Map<String, dynamic>? map = await Http.post('/user/gesture', data: {'old': '', 'new': value, 'repeat': value});
                  if (map == null || !map.containsKey('code')) {
                    return Future.value(S.of(context).httpFailure);
                  }

                  if (map['code'] > 0) return Future.value(map['message']);

                  await User.sign();
                  setState(() {});

                  return Future.value(null);
                }

                Map<String, dynamic>? map = await Http.post('/user/gesture-off', data: {'gesture': value});
                if (map == null || !map.containsKey('code')) {
                  return Future.value(S.of(context).httpFailure);
                }

                if (map['code'] > 0) return Future.value(map['message']);

                await User.sign();
                setState(() {});

                return Future.value(null);
              },
            ));
      });
}