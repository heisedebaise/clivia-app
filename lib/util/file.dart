import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../context.dart';

ImagePicker _imagePicker = ImagePicker();

Future<String?> pickImage(ImageSource source) async {
  if (Context.mobile) {
    XFile? xfile = await _imagePicker.pickImage(source: source);

    return Future.value(xfile?.path);
  }

  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
  if (result == null) return null;

  return Future.value(kIsWeb ? _imageBase64(result.files.first) : result.paths.first);
}

Future<List<String>?> pickImages() async {
  if (Context.mobile) {
    List<XFile>? xfiles = await _imagePicker.pickMultiImage();
    if (xfiles == null || xfiles.isEmpty) return Future.value(null);

    List<String> list = [];
    for (XFile xfile in xfiles) {
      list.add(xfile.path);
    }

    return Future.value(list);
  }

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.image,
  );
  if (result == null || result.paths.isEmpty) return Future.value(null);

  List<String> list = [];
  for (String? path in result.paths) {
    if (path != null) list.add(path);
  }

  return Future.value(list);
}

Future<String?> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  return Future.value(result?.paths.first);
}

String _imageBase64(PlatformFile file) {
  if (file.extension == null || file.bytes == null) return '';

  String type = file.extension!.toLowerCase();
  if (type == 'jpg') type = 'jpeg';

  return 'data:image/$type;base64,${base64Encode(file.bytes!)}';
}
