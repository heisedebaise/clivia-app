import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(S.of(context).mePrivacyPolicy),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {},
      );
}
