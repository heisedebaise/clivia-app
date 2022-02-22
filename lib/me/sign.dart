import 'package:flutter/material.dart';

import '../components/avatar.dart';
import '../generated/l10n.dart';
import '../user.dart';
import '../util/router.dart';
import '../util/style.dart';
import 'sign/inup.dart';
import 'sign/main.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignState();
}

class _SignState extends State<Sign> {
  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 4),
        shape: const RoundedRectangleBorder(),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                child: Avatar(uri: User.avatar(''), nick: User.nick('')),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      User.nick(S.of(context).meSignNickEmpty),
                      style: Style.tileTitle(context),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ID: ${User.code('00000000')}',
                            style: Style.tileSubtitle(Theme.of(context)),
                          ),
                        ),
                        Icon(
                          Icons.qr_code_2,
                          color: Style.tileIcon(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Style.tileIcon(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            PageRouter.push(
              context,
              User.on() ? const SignPage() : const InUpPage(),
            ).then((value) {
              setState(() {});
            });
          },
        ),
      );
}
