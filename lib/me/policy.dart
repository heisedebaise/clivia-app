import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../components/popage.dart';
import '../generated/l10n.dart';
import '../util/http.dart';
import '../util/io.dart';
import '../util/router.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(S.of(context).mePrivacyPolicy),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          PageRouter.push(context, const PrivacyPolicyPage());
        },
      );
}

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  PdfControllerPinch? controller;

  @override
  void initState() {
    super.initState();
    Http.service('/keyvalue/object', data: {'key': 'setting.privacy-policy'}).then((data) async {
      if (data == null) return;

      String value = data['setting.privacy-policy'] ?? '';
      if (value == '') return;

      dynamic array = json.decode(value);
      if (array == null || array.length == 0) return;

      String uri = array[0]['uri'] ?? '';
      if (uri == '') return;

      String path = Io.absolute(uri.substring(1));
      if (!Io.existsSync(path)) await Http.download(uri, path);
      setState(() {
        controller = PdfControllerPinch(document: PdfDocument.openFile(path));
      });
    });
  }

  @override
  Widget build(BuildContext context) => PopPage(
        close: true,
        title: S.of(context).mePrivacyPolicy,
        body: controller == null ? null : PdfViewPinch(controller: controller!),
      );

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
