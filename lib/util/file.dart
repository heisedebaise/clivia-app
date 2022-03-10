import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../context.dart';

ImagePicker _imagePicker = ImagePicker();

Future<String?> pickImage(ImageSource source) async {
  if (Context.mobile) {
    XFile? xfile = await _imagePicker.pickImage(source: source);

    return Future.value(xfile?.path);
  }

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp'],
  );

  return Future.value(result?.paths.first);
}

Future<String?> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  return Future.value(result?.paths.first);
}
