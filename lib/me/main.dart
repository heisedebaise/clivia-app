import 'package:flutter/material.dart';

import 'aboutus.dart';
import 'feedback.dart';
import 'privacy.dart';
import 'settings.dart';
import 'sign.dart';
import 'uploadlog.dart';
import 'version.dart';

class MePage extends StatelessWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          const Sign(),
          const Settings(),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FeedBack(),
                Divider(height: 1),
                Version(),
                Divider(height: 1),
                UploadLog(),
                Divider(height: 1),
                PrivacyAgreement(),
                Divider(height: 1),
                AboutUs(),
              ],
            ),
          ),
        ],
      );
}
