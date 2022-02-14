import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../util/http.dart';
import '../util/style.dart';

class Avatar extends StatelessWidget {
  final String uri;
  final String nick;
  final double size;

  const Avatar({Key? key, this.uri = '', this.nick = '', this.size = 64}) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(size / 8),
        child: icon(context),
      );

  Widget icon(BuildContext context) {
    if (uri != '') {
      return ExtendedImage.network(
        Http.url(uri),
        width: size,
        height: size,
      );
    }

    if (nick.isNotEmpty) {
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

    return Icon(
      Icons.person,
      size: size,
      color: Theme.of(context).brightness == Brightness.light ? Colors.black45 : null,
    );
  }
}
