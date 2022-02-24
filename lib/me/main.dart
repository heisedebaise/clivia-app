import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../context.dart';
import '../generated/l10n.dart';
import '../notifier.dart';
import '../user.dart';
import 'aboutus.dart';
import 'feedback.dart';
import 'language.dart';
import 'lockscreen.dart';
import 'privacy.dart';
import 'sign.dart';
import 'uploadlog.dart';
import 'version.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  Widget divider = const Divider(height: 1);

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          Sign(setState: setState),
          settings(),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FeedBack(),
                divider,
                const Version(),
                divider,
                const UploadLog(),
                divider,
                const PrivacyAgreement(),
                divider,
                const AboutUs(),
              ],
            ),
          ),
        ],
      );

  Widget settings() {
    List<Widget> children = [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(S.of(context).meSettings),
      ),
      divider,
      const Language(),
    ];
    if (User.on()) {
      children.add(divider);
      children.add(const LockScreen());
    }
    children.add(divider);
    children.add(SwitchListTile(
      title: Text(S.of(context).meSettingsDark),
      subtitle: Text(S.of(context).meSettingsDarkExplain),
      value: Theme.of(context).brightness == Brightness.dark,
      onChanged: (bool on) async {
        await Context.set('theme', on ? 'dark' : 'light');
        Provider.of<Notifier>(context, listen: false).notify();
      },
    ));

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
