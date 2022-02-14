import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../context.dart';
import '../generated/l10n.dart';
import '../notifier.dart';
import 'language.dart';
import 'lockscreen.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Divider divider = const Divider(height: 1);

  @override
  Widget build(BuildContext context) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(S.of(context).meSettings),
            ),
            divider,
            const Language(),
            divider,
            const LockScreen(),
            divider,
            SwitchListTile(
              title: Text(S.of(context).meSettingsDark),
              subtitle: Text(S.of(context).meSettingsDarkExplain),
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (bool on) async {
                await Context.set('theme', on ? 'dark' : 'light');
                Provider.of<Notifier>(context, listen: false).notify();
              },
            ),
          ],
        ),
      );
}
