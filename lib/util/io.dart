import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class Io {
  static String? _dir;

  static Future<void> init() async {
    _dir = (await getApplicationDocumentsDirectory()).path;
    if (!_dir!.endsWith('/')) _dir = '${_dir!}/';
    _dir = _dir?.replaceAll('/app_flutter/', '/');
  }

  static Future<bool> exists(String path) async {
    return File(absolute(path)).exists();
  }

  static bool existsSync(String path) {
    return File(absolute(path)).existsSync();
  }

  static Future<void> mkdirs(String path) async {
    await Directory(absolute(path)).create(recursive: true);
  }

  static void mkdirsSync(String path) {
    Directory(absolute(path)).createSync(recursive: true);
  }

  static Future<String?> readAsString(String name) async {
    File file = File(absolute(name));

    return file.existsSync() ? file.readAsStringSync() : null;
  }

  static Future<void> writeString(String name, String string) async => File(absolute(name)).writeAsStringSync(string);

  static Future<void> write(String name, Uint8List bytes) async => File(absolute(name)).writeAsBytes(bytes);

  static void writeSync(String name, Uint8List bytes) => File(absolute(name)).writeAsBytesSync(bytes);

  static Future<void> delete(String name) async => File(absolute(name)).delete();

  static void deleteSync(String name) async => File(absolute(name)).deleteSync();

  static String absolute(String path) {
    if (path == '') return _dir!;

    if (path[0] == '/') return path;

    return _dir! + path;
  }
}