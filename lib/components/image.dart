import 'dart:typed_data';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart';

Future<List<int>?> cropImage(ExtendedImageEditorState state, Uint8List rawImageData) async {
  Animation? src = await compute(decodeAnimation, rawImageData);
  if (src == null) return null;

  EditActionDetails? action = state.editAction;
  src.frames = src.frames.map((Image image) {
    image = bakeOrientation(image);

    if (action!.needCrop) {
      Rect? rect = state.getCropRect();
      if (rect != null) image = copyCrop(image, rect.left.toInt(), rect.top.toInt(), rect.width.toInt(), rect.height.toInt());
    }

    if (action.needFlip) {
      Flip? mode;
      if (action.flipY && action.flipX) {
        mode = Flip.both;
      } else if (action.flipY) {
        mode = Flip.horizontal;
      } else if (action.flipX) {
        mode = Flip.vertical;
      }
      image = flip(image, mode!);
    }

    if (action.hasRotateAngle) image = copyRotate(image, action.rotateAngle);

    return image;
  }).toList();

  return src.numFrames == 1 ? await compute(_encodeJpg75, src.first) : await compute(encodeGifAnimation, src);
}

List<int> _encodeJpg75(Image image) => encodeJpg(image, quality: 75);
