import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class UploadLog extends StatelessWidget {
  const UploadLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(S.of(context).meUploadLog),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () async {
          await showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => AlertDialog(
              content: Text(S.of(context).meUploadLogMemo),
              actions: <Widget>[
                TextButton(
                  child: Text(S.of(context).ok),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(S.of(context).cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
}
