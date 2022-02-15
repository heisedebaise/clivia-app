import 'package:flutter/material.dart';

class PopPage extends StatelessWidget {
  final bool popable;
  final bool close;
  final String title;
  final List<Widget>? actions;
  final Widget? body;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final BottomNavigationBar? bottomNavigationBar;

  const PopPage({
    Key? key,
    this.popable = true,
    this.close = false,
    this.title = '',
    this.actions,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: close ? Theme.of(context).scaffoldBackgroundColor : null,
          leading: popable
              ? GestureDetector(
                  child: Icon(
                    close ? Icons.close : Icons.arrow_back,
                    color: close ? Theme.of(context).textTheme.bodyText1?.color : Theme.of(context).appBarTheme.titleTextStyle?.color,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              : Container(),
          title: Text(
            title,
            style: TextStyle(
              color: close ? Theme.of(context).textTheme.bodyText1?.color : Theme.of(context).appBarTheme.iconTheme?.color,
            ),
          ),
          centerTitle: true,
          actions: actions,
          elevation: close ? 0 : Theme.of(context).appBarTheme.elevation,
        ),
        body: body == null ? null : SafeArea(child: body!),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
      );
}
