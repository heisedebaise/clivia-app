import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../components/popage.dart';
import '../generated/l10n.dart';
import '../util/http.dart';
import '../util/io.dart';
import '../util/keyvalue.dart';
import '../util/router.dart';

class PrivacyAgreement extends StatelessWidget {
  const PrivacyAgreement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(S.of(context).mePrivacyAgreement),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          PageRouter.push(context, const PrivacyAgreementPage());
        },
      );
}

class PrivacyAgreementPage extends StatefulWidget {
  const PrivacyAgreementPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PrivacyAgreementPageState();
}

class _PrivacyAgreementPageState extends State<PrivacyAgreementPage> {
  PdfController? controller;

  @override
  void initState() {
    super.initState();
    Keyvalue.value('setting.agreement.privacy').then((value) async {
      if (value == '') return;

      dynamic array = json.decode(value);
      if (array == null || array.length == 0) return;

      String uri = array[0]['uri'] ?? '';
      if (uri == '') return;

      String path = Io.absolute(uri.substring(1));
      await Http.download(uri, path);
      setState(() {
        controller = PdfController(document: PdfDocument.openFile(path));
      });
    });
  }

  @override
  Widget build(BuildContext context) => PopPage(
        close: true,
        title: S.of(context).mePrivacyAgreement,
        body: controller == null ? null : PdfView(controller: controller!),
      );

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
