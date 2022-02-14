import 'package:flutter/material.dart';

import '../components/popage.dart';
import '../generated/l10n.dart';
import '../util/router.dart';
import '../util/style.dart';

class FeedBack extends StatelessWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(S.of(context).meFeedback),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          PageRouter.push(context, const FeedBackPage());
        },
      );
}

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) => PopPage(
        close: true,
        title: S.of(context).meFeedback,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).meFeedbackMemo,
                style: Style.tileSubtitle(Theme.of(context)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
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
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).submit),
                ),
              ),
            ],
          ),
        ),
      );
}
