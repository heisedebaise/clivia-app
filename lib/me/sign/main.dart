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
import 'destroy.dart';
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
            const DestroyPassword(),
            divider,
            Destroy(),
            divider,
            button(
              S.of(context).meSignOut,
              () async {
                await User.signOut();
                if (User.anonymous) {
                  Navigator.pop(context);
                } else {
                  await PageRouter.push(context, const InUpPage());
                  Navigator.pop(context);
                }
              },
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
          Widget? widget = page(index);
          if (widget != null) {
            dynamic back = await PageRouter.push(context, widget);
            if (back != null && back) setState(() {});
          }
        },
      );

  Widget? page(int index) {
    switch (index) {
      case 0:
        return PicturePage(
          title: S.of(context).meSignAvatarChange,
          upload: 'clivia.user.avatar',
          uri: User.avatar(''),
          ratio: 1,
          ok: (uri) async {
            await User.modify(context, {'avatar': uri});
            setState(() {});
          },
        );
      case 1:
        return ChangePage(
          S.of(context).meSignNickChange,
          Icons.face_retouching_natural,
          'nick',
          S.of(context).meSignNickChangeMemo,
        );
      case 2:
        return ChangePage(
          S.of(context).meSignMobileChange,
          Icons.phone,
          'mobile',
          '',
        );
      case 3:
        return ChangePage(
          S.of(context).meSignEmailChange,
          Icons.email,
          'email',
          '',
        );
      case 4:
        QrCode.show(
          context,
          'clivia:user:${User.code('')}',
          image: ExtendedNetworkImageProvider(
            Http.url(User.avatar('')),
            cache: true,
          ),
        );
        return null;
      default:
        return null;
    }
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
                return await User.passwordOnOff(context, on, 'gesture', value, setState, S.of(context).meSignGestureWrong);
              },
            ),
          );
        },
      );

  Widget button(String label, void Function() tap) => Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: Text(label),
            onPressed: tap,
          ),
        ),
      );
}
