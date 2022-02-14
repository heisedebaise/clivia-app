import 'package:flutter/material.dart';

import 'aboutus.dart';
import 'feedback.dart';
import 'settings.dart';
import 'sign.dart';
import 'uploadlog.dart';
import 'version.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  final Divider divider = const Divider(height: 1);

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          const Sign(),
          const Settings(),
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
                const AboutUs(),
              ],
            ),
          ),
        ],
      );
}
