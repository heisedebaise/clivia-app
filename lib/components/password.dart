import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gesture_password_widget/gesture_password_widget.dart';

import '../context.dart';
import '../generated/l10n.dart';
import '../util/style.dart';
import 'popage.dart';

class PasswordPage extends StatefulWidget {
  final String title;
  final String level;
  final bool popable;
  final bool full;
  final int min;
  final bool twice;
  final Future<String?> Function(String value)? complete;

  const PasswordPage(
    this.title,
    this.level, {
    Key? key,
    this.popable = true,
    this.full = false,
    this.min = 4,
    this.twice = false,
    this.complete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  String message = '';
  String? value;
  int navigation = 0;
  double radius = 30;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    navigation = Context.get(widget.level, defaultValue: 0);
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      child: PopPage(
        popable: widget.popable,
        close: true,
        title: widget.title,
        actions: [
          navigation > 2
              ? IconButton(
                  onPressed: () async {
                    await onComplete(controller.text);
                  },
                  icon: Icon(
                    Icons.done,
                    color: Style.body(context)?.color,
                  ),
                )
              : Container(),
        ],
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: [
              SizedBox(
                height: 128,
                child: Center(
                  child: Text(msg()),
                ),
              ),
              body(),
            ],
          ),
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: items(),
          type: BottomNavigationBarType.fixed,
          currentIndex: navigation,
          onTap: (int index) {
            setState(() {
              navigation = index;
              radius = 30.0 - index * 10.0;
              message = '';
              value = null;
              controller.text = '';
            });
          },
        ),
      ),
      onWillPop: () => Future.value(widget.popable));

  String msg() {
    if (message == '') {
      if (widget.twice) return navigation > 2 ? S.of(context).passwordInputNew : S.of(context).passwordGestureNew;

      return '';
    }

    return message;
  }

  Widget body() {
    if (navigation == 3) {
      return digits();
    }

    if (navigation > 3) {
      return text();
    }

    return gesture();
  }

  Widget digits() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          obscureText: true,
          obscuringCharacter: '☼',
          textAlign: TextAlign.center,
          autofocus: true,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          controller: controller,
        ),
      );

  Widget text() => Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: TextField(
            minLines: 99,
            maxLines: 999,
            autofocus: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              isDense: true,
              border: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.none,
                ),
              ),
            ),
            controller: controller,
          ),
        ),
      );

  Widget gesture() => Center(
        child: GesturePasswordWidget(
          singleLineCount: 2 * navigation + 3,
          identifySize: 50.0 - navigation * 10.0,
          normalItem: Container(
            width: radius,
            height: radius,
            decoration: BoxDecoration(
              color: Theme.of(context).unselectedWidgetColor,
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          selectedItem: Container(
            width: 2 * radius,
            height: 2 * radius,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(2 * radius),
            ),
            child: Center(
              child: Container(
                width: radius,
                height: radius,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(radius),
                ),
              ),
            ),
          ),
          lineColor: Theme.of(context).colorScheme.secondary,
          onComplete: (data) async {
            await onComplete(data.join(','));
          },
        ),
      );

  List<BottomNavigationBarItem> items() {
    List<BottomNavigationBarItem> list = [
      item(Icons.filter_3, S.of(context).passwordStandard),
      item(Icons.filter_5, S.of(context).passwordAdvanced),
      item(Icons.filter_7, S.of(context).passwordProfessional),
    ];
    if (widget.full) {
      list.add(item(Icons.dialpad, S.of(context).passwordDigit));
      list.add(item(Icons.keyboard_outlined, S.of(context).passwordText));
    }

    return list;
  }

  BottomNavigationBarItem item(IconData icon, String label) => BottomNavigationBarItem(
        icon: Icon(icon),
        label: label,
      );

  Future<void> onComplete(String value) async {
    if (value.length < widget.min || (navigation <= 2 && value.split(',').length < widget.min)) {
      setState(() {
        message = navigation > 2
            ? '${S.of(context).passwordInputMinPrefix}${widget.min}${S.of(context).passwordInputMinSuffix}'
            : '${S.of(context).passwordGestureMinPrefix}${widget.min}${S.of(context).passwordGestureMinSuffix}';
      });

      return;
    }

    if (widget.twice) {
      if (this.value == null) {
        setState(() {
          this.value = value;
          message = navigation > 2 ? S.of(context).passwordInputRepeat : S.of(context).passwordGestureRepeat;
          controller.text = '';
        });

        return;
      }

      if (value != this.value) {
        setState(() {
          this.value = null;
          message = S.of(context).passwordNotEquals;
        });

        return;
      }
    }

    if (widget.complete == null) {
      await Context.set(widget.level, navigation);
      Navigator.pop(context, value);

      return;
    }

    String? string = await widget.complete!(value);
    if (string == null) {
      await Context.set(widget.level, navigation);
      Navigator.pop(context, value);
    } else {
      setState(() {
        message = string;
      });
    }
  }
}
