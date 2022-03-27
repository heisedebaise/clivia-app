import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class Piclocal extends StatelessWidget {
  final String local;
  final Key extendedImageEditorKey;
  final InitEditorConfigHandler initEditorConfigHandler;

  const Piclocal({
    Key? key,
    required this.local,
    required this.extendedImageEditorKey,
    required this.initEditorConfigHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ExtendedImage.network(
        local,
        cache: true,
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,
        extendedImageEditorKey: extendedImageEditorKey,
        cacheRawData: true,
        initEditorConfigHandler: initEditorConfigHandler,
      );
}
