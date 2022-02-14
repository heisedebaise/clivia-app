import 'package:flutter/material.dart';

import '../../components/password.dart';
import '../../components/popage.dart';
import '../../generated/l10n.dart';
import '../../user.dart';
import '../../util/router.dart';
import '../language.dart';
import '../privacy.dart';

class InUpPage extends StatefulWidget {
  const InUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InUpPageState();
}

class _InUpPageState extends State<InUpPage> {
  bool up = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeat = TextEditingController();
  TextEditingController nick = TextEditingController();
  bool visibility = false;
  bool agree = false;

  @override
  void initState() {
    super.initState();
    username.text = User.username();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (User.gesture()) {
        PageRouter.push(
          context,
          PasswordPage(
            S.of(context).meSignIn,
            'user.sign-in.gesture',
            complete: (value) async {
              String? string = await User.signInGesture(context, value);
              if (string == null) Navigator.pop(context);

              return Future.value(string);
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      child: PopPage(
        popable: User.anonymous,
        close: true,
        title: up ? S.of(context).meSignUp : S.of(context).meSignIn,
        actions: User.anonymous
            ? null
            : [
                Language(
                  icon: true,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
              ],
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            children: children(),
          ),
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ),
      onWillPop: () => Future.value(User.anonymous));

  List<Widget> children() {
    List<Widget> list = [];
    list.add(text(Icons.person, S.of(context).meSignUsername, username));
    list.add(pass(S.of(context).meSignPassword, password));
    if (up) {
      list.add(pass(S.of(context).meSignPasswordRepeat, repeat));
      list.add(text(
        Icons.face_retouching_natural,
        S.of(context).meSignNickNew,
        nick,
      ));
      list.add(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: agree,
            onChanged: (value) {
              setState(() {
                agree = value ?? false;
              });
            },
          ),
          TextButton(
            onPressed: () {
              PageRouter.push(context, const PrivacyAgreementPage());
            },
            child: Text(S.of(context).meSignUpPrivacyAgreement),
          ),
        ],
      ));
      list.add(elevated(S.of(context).meSignUp));
      list.add(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                up = false;
              });
            },
            child: Text(S.of(context).meSignToIn),
          ),
        ],
      ));
    } else {
      list.add(elevated(S.of(context).meSignIn));
      list.add(Row(
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                up = true;
              });
            },
            child: Text(S.of(context).meSignToUp),
          ),
          Expanded(
            child: Container(),
          ),
          TextButton(
            onPressed: () {},
            child: Text(S.of(context).meSignPasswordForget),
          ),
        ],
      ));
    }

    return list;
  }

  Widget text(IconData icon, String label, TextEditingController controller) => TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
        ),
        controller: controller,
      );

  Widget pass(String label, TextEditingController controller) => TextField(
        obscureText: !visibility,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          labelText: label,
          suffixIcon: GestureDetector(
            child: Icon(visibility ? Icons.visibility : Icons.visibility_off),
            onTap: () {
              setState(() {
                visibility = !visibility;
              });
            },
          ),
        ),
        controller: controller,
      );

  Widget elevated(String text) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: up && !agree
              ? null
              : () async {
                  if (up) {
                    if (await User.signUp(
                      context,
                      username.text,
                      password.text,
                      nick.text,
                    )) Navigator.pop(context);
                  } else {
                    if (await User.signIn(context, username.text, password.text)) Navigator.pop(context);
                  }
                },
          child: Text(text),
        ),
      );
}
