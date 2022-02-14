import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../components/popage.dart';
import '../generated/l10n.dart';
import '../util/router.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(S.of(context).meAboutUs),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          PageRouter.push(context, const AboutUsPage());
        },
      );
}

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) => PopPage(
        close: true,
        title: S.of(context).meAboutUs,
        body: const WebView(
          initialUrl: 'https://github.com/heisedebaise/clivia-mobile',
        ),
      );
}
