import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../context.dart';
import '../generated/l10n.dart';
import '../notifier.dart';
import 'language.dart';
import 'lockscreen.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(S.of(context).meSettings),
            ),
            const Divider(height: 1),
            const Language(),
            const Divider(height: 1),
            const LockScreen(),
            const Divider(height: 1),
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
