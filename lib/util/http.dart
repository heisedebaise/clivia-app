import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import '../context.dart';
import '../generated/l10n.dart';
import '../user.dart';
import 'generator.dart';
import 'io.dart';
import 'toast.dart';

class Http {
  static String? _sid;
  static final Set<String> _downloading = {};

  static Future<dynamic> service(String uri, {dynamic data, bool message = false, BuildContext? context}) async {
    Map<String, dynamic>? map = await post(uri, data: data, context: context);
    if (map == null) return Future.value(null);

    if (message && map.containsKey('message')) {
      String message = map['message'];
      if (message != '') {
        int code = map['code'];
        if (code == 0) {
          Toast.info(message);
        } else {
          Toast.error(map['code'], message);
        }
      }
    }

    return Future.value(map.containsKey('data') ? map['data'] : null);
  }

  static Future<Map<String, dynamic>?> post(String uri, {dynamic data, BuildContext? context}) async {
    Response? response = await _post(uri, data);
    if (response == null || response.statusCode != 200) {
      return {
        'code': response == null ? 500 : response.statusCode,
        'message': context == null ? 'HTTP fail' : S.of(context).httpFailure,
      };
    }

    if (uri == '/user/sign-out') {
      _sid = null;
      await Context.remove('psid');
    }

    String? destroy = response.headers.value('user-destroy');
    if (destroy != null) {
      await User.delete(destroy);
    }

    return response.data;
  }

  static Future<Map<String, dynamic>?> upload(String name,
      {String? file, List<int>? bytes, String? filename, String? contentType, BuildContext? context}) async {
    MultipartFile? mf;
    MediaType? mt = contentType == null ? null : MediaType.parse(contentType);
    if (file != null) {
      mf = await MultipartFile.fromFile(file, filename: filename, contentType: mt);
    } else if (bytes != null) {
      mf = MultipartFile.fromBytes(bytes, filename: filename, contentType: mt);
    }
    if (mf == null) return Future.value(null);

    Response? response = await _post('/photon/ctrl-http/upload', FormData.fromMap({name: mf}));
    if (response == null || response.statusCode != 200) {
      return {
        'code': response == null ? 500 : response.statusCode,
        'message': context == null ? 'HTTP fail' : S.of(context).httpFailure,
      };
    }

    return Future.value(response.data);
  }

  static Future<Response?> _post(String uri, dynamic data) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        _url(uri),
        data: data,
        options: Options(headers: {
          'photon-session-id': sid(),
          'accept-language': Context.locale()!.languageCode,
        }),
      );
      dio.close();
      return Future.value(response);
    } on Exception {
      return Future.value(null);
    }
  }

  static Future<bool> download(String uri, String path) async {
    if (kIsWeb) return Future.value(false);

    if (_downloading.contains(path)) {
      for (; true;) {
        await Future.delayed(const Duration(seconds: 1));
        if (!_downloading.contains(path)) return Future.value(true);
      }
    }

    _downloading.add(path);
    await Io.mkdirs(path.substring(0, path.lastIndexOf(Platform.pathSeparator)));
    String downloading = path + '.downloading';
    try {
      Dio dio = Dio();
      Response response = await dio.download(
        _url(uri),
        downloading,
        options: Options(headers: {
          'photon-session-id': sid(),
          'accept-language': Context.locale()!.languageCode,
        }),
      );
      dio.close();
      await Io.rename(downloading, path);
      _downloading.remove(path);
      return Future.value(response.statusCode == 200);
    } on Exception {
      await Io.delete(downloading);
      _downloading.remove(path);
      return Future.value(false);
    }
  }

  static String sid() {
    if (_sid == null) {
      _sid = Context.get('psid');
      if (_sid == null) {
        _sid = Generator.string(64);
        Context.set('psid', _sid);
      }
    }

    return _sid!;
  }

  static String url(String? string) {
    if (string == null) return '';

    return string.contains('://') ? string : _url(string);
  }

  static String _url(String uri) {
    if (kIsWeb) return uri;

    return 'http://${Context.host()}:8080$uri';
  }
}
