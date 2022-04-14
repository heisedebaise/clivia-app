import 'package:flutter/material.dart';

import '../../components/popage.dart';
import '../../generated/l10n.dart';
import '../../user.dart';
import '../../util/style.dart';

class ChangePage extends StatefulWidget {
  final String title;
  final IconData icon;
  final String name;
  final String memo;

  const ChangePage(this.title, this.icon, this.name, this.memo, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChangePageState();
}

class _ChangePageState extends State<ChangePage> {
  TextEditingController? controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: User.get(widget.name, ''));
  }

  @override
  Widget build(BuildContext context) => PopPage(
        title: widget.title,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            children: [
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(widget.icon),
                ),
                controller: controller,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                child: widget.memo == ''
                    ? Container()
                    : Text(
                        widget.memo,
                        style: Style.tileSubtitle(Theme.of(context)),
                      ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (await User.modify({widget.name: controller!.text})) {
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text(S.of(context).save),
                ),
              ),
            ],
          ),
        ),
      );
}
