import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../components/popage.dart';
import '../generated/l10n.dart';
import '../upgrader.dart';
import '../util/router.dart';
import '../util/style.dart';

class Version extends StatelessWidget {
  const Version({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Row(
          children: [
            Expanded(child: Text(S.of(context).meVersion)),
            name(context),
          ],
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          PageRouter.push(context, const VersionPage());
        },
      );

  Widget name(BuildContext context) {
    Text text = Text(
      Upgrader.name(),
      style: Style.tileSubtitle(Theme.of(context)),
    );

    return Upgrader.newer() ? Badge(child: text) : text;
  }
}

class VersionPage extends StatelessWidget {
  const VersionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => PopPage(
        close: true,
        title: S.of(context).meVersion,
        body: ListView(
          children: [
            const Icon(
              Icons.copyright,
              size: 256,
            ),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(Upgrader.name()),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(Upgrader.explain()),
                  ),
                ],
              ),
            ),
            newer(context),
          ],
        ),
      );

  Widget newer(BuildContext context) {
    if (!Upgrader.newer()) return Container();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: Upgrader.forward,
          child: Text(S.of(context).meVersionForward),
        ),
      ),
    );
  }
}
