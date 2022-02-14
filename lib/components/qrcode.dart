import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../util/router.dart';

class QrCode {
  static void show(BuildContext context, String content, {ImageProvider? image}) {
    PageRouter.push(context, QrCodePage(content, image: image));
  }

  static Future<String?> scan(BuildContext context) => PageRouter.push(context, const QrScanerPage());
}

class QrCodePage extends StatelessWidget {
  final String content;
  final ImageProvider? image;

  const QrCodePage(this.content, {Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Center(
              child: QrImage(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
                data: content,
                version: QrVersions.auto,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Platform.isAndroid ? 32 : 16),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      );
}

class QrScanerPage extends StatefulWidget {
  const QrScanerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScanerPageState();
}

class _QrScanerPageState extends State<QrScanerPage> {
  Barcode? barcode;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            QRView(
              key: GlobalKey(debugLabel: 'QR'),
              onQRViewCreated: (QRViewController controller) {
                this.controller = controller;
                controller.scannedDataStream.listen((barcode) async {
                  await controller.pauseCamera();
                  await controller.resumeCamera();
                  Navigator.pop(context, barcode.code);
                });
              },
            ),
            Column(
              children: [
                Expanded(child: Container()),
                Row(
                  children: [
                    button(Icons.close, () {
                      Navigator.pop(context);
                    }),
                    button(Icons.flash_on, () async {
                      await controller?.toggleFlash();
                    }),
                    button(Icons.flip_camera_ios, () async {
                      await controller?.flipCamera();
                    }),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

  Widget button(IconData icon, void Function() onPressed) => Expanded(
        child: IconButton(
          icon: Icon(
            icon,
          ),
          onPressed: onPressed,
        ),
      );

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
