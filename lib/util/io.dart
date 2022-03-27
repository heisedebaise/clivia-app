import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../context.dart';

class Io {
  static String? _dir;

  static Future<void> init() async {
    if (kIsWeb) return;

    _dir = Context.mobile ? (await getApplicationDocumentsDirectory()).path : Directory.current.path;
    if (!_dir!.endsWith(Platform.pathSeparator)) _dir = _dir! + Platform.pathSeparator;
    _dir = _dir!.replaceAll(Platform.pathSeparator + 'app_flutter' + Platform.pathSeparator, Platform.pathSeparator);
    _dir = _dir! + 'dataset' + Platform.pathSeparator;
    await mkdirs(_dir!);
  }

  static Future<bool> exists(String path) async {
    if (kIsWeb) return Future.value(false);

    return File(absolute(path)).exists();
  }

  static bool existsSync(String path) {
    if (kIsWeb) return false;

    return File(absolute(path)).existsSync();
  }

  static Future<void> mkdirs(String path) async {
    if (kIsWeb) return;

    await Directory(absolute(path)).create(recursive: true);
  }

  static void mkdirsSync(String path) {
    if (kIsWeb) return;

    Directory(absolute(path)).createSync(recursive: true);
  }

  static Future<String?> readAsString(String name) async {
    if (kIsWeb) return Future.value(null);

    File file = File(absolute(name));

    return file.existsSync() ? file.readAsStringSync() : null;
  }

  static Future<void> writeString(String name, String string) async {
    if (kIsWeb) return;

    File(absolute(name)).writeAsStringSync(string);
  }

  static Future<void> write(String name, Uint8List bytes) async {
    if (kIsWeb) return;

    File(absolute(name)).writeAsBytes(bytes);
  }

  static void writeSync(String name, Uint8List bytes) {
    if (kIsWeb) return;

    File(absolute(name)).writeAsBytesSync(bytes);
  }

  static Future<void> rename(String source, String target) async {
    if (kIsWeb) return;

    File(absolute(source)).rename(absolute(target));
  }

  static void renameSync(String source, String target) {
    if (kIsWeb) return;

    File(absolute(source)).renameSync(absolute(target));
  }

  static Future<void> delete(String name) async {
    if (kIsWeb) return;

    File(absolute(name)).delete(recursive: true);
  }

  static void deleteSync(String name) async {
    if (kIsWeb) return;

    File(absolute(name)).deleteSync(recursive: true);
  }

  static String absolute(String path) {
    if (kIsWeb) return path;

    if (path == '') return _dir!;

    if (Platform.isWindows) {
      if (path.contains(':\\')) {
        return path;
      }
    } else if (path[0] == Platform.pathSeparator) {
      return path;
    }

    return _dir! + path.replaceAll('/', Platform.pathSeparator);
  }
}
