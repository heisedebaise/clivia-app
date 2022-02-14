import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Io {
  static String? _dir;

  static Future<void> mkdirs(String path) async {
    await Directory(await _path(path)).create(recursive: true);
  }

  static Future<String?> readAsString(String name) async {
    File file = File(await _path(name));

    return file.existsSync() ? file.readAsStringSync() : null;
  }

  static Future<void> writeString(String name, String string) async => File(await _path(name)).writeAsStringSync(string);

  static Future<String> _path(String path) async {
    _dir ??= (await getApplicationDocumentsDirectory()).path;

    return _dir! + path;
  }
}
