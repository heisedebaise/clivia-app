import 'dart:convert';

import 'http.dart';
import 'io.dart';

class Storage {
  static Future<dynamic> load(String path, {String? uri, Map<String, dynamic>? data, void Function(dynamic data)? remote}) async {
    int index = path.lastIndexOf('/');
    if (index > -1) await Io.mkdirs(path.substring(0, index));

    if (uri != null) {
      Http.service(uri, data: data).then((value) async {
        if (value == null) return;

        await Io.writeString(path, value.toString());
        if (remote != null) remote(value);
      });
    }

    return _load(path);
  }

  static Future<dynamic> _load(String path) async {
    String? string = await Io.readAsString(path);
    if (string == null) return null;

    if ((string.startsWith('{') && string.endsWith('}')) || (string.startsWith('[') && string.endsWith(']'))) {
      try {
        return json.decode(string);
      } catch (_) {}
    }

    return Future.value(string);
  }
}
