import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../context.dart';
import '../generated/l10n.dart';
import '../notifier.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final Divider divider = const Divider(height: 1);
  final Map<String, String> map = {
    'en': 'English',
    'zh': '简体中文',
  };
  String key = Context.get('language', defaultValue: 'en');

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(S.of(context).meLanguage),
        subtitle: Text(map[key]!),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (builder) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(S.of(context).meLanguageSelect),
                ),
                divider,
                item('en'),
                divider,
                item('zh')
              ],
            ),
          );
        },
      );

  Widget item(String key) => ListTile(
        title: Text(map[key]!),
        trailing: key == this.key ? const Icon(Icons.check) : null,
        onTap: () async {
          Context.set('language', key);
          setState(() {
            this.key = key;
          });
          Provider.of<Notifier>(context, listen: false).notify();
        },
      );
}
