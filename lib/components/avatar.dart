import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../util/http.dart';
import '../util/style.dart';
import 'cachedimage.dart';

class Avatar extends StatelessWidget {
  final String uid;
  final String uri;
  final String nick;
  final double size;

  const Avatar({Key? key, this.uid = '', this.uri = '', this.nick = '', this.size = 64}) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(size / 8),
        child: GestureDetector(
          child: _image(),
          onTap: () {
            if (uid == '') return;
          },
        ),
      );

  Widget _image() {
    if (kIsWeb) {
      return Image.network(
        Http.url(uri),
        width: size,
        height: size,
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => _placeholder(context),
      );
    }

    return CachedImage(
      uri: uri,
      width: size,
      height: size,
      placeholder: _placeholder,
    );
  }

  Widget _placeholder(BuildContext context) {
    if (nick.isEmpty) {
      return Icon(
        Icons.person,
        size: size,
        color: Theme.of(context).brightness == Brightness.light ? Colors.black45 : null,
      );
    }

    return Container(
      color: Colors.black26,
      width: size,
      height: size,
      child: Center(
        child: Text(
          nick[0],
          style: TextStyle(
            color: Style.tileIcon(context),
            fontSize: size * 0.5,
          ),
        ),
      ),
    );
  }
}
