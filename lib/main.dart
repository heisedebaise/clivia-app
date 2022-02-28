import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'context.dart';
import 'generated/l10n.dart';
import 'me/lockscreen.dart';
import 'me/main.dart';
import 'notifier.dart';
import 'upgrader.dart';
import 'user.dart';
import 'util/io.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Io.init();
  await Context.init();
  User.sign();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<Notifier>.value(value: Notifier()),
        ],
        child: Consumer<Notifier>(
          builder: (context, notifier, _) => MaterialApp(
            onGenerateTitle: (context) => S.of(context).title,
            debugShowCheckedModeBanner: false,
            theme: Context.theme(),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            localeListResolutionCallback: Context.localeCallback,
            locale: Context.locale(),
            home: const MainPage(),
            builder: EasyLoading.init(),
            navigatorKey: Context.navigatorKey,
          ),
        ),
      );
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  int navigation = 0;
  Widget? me;

  @override
  void initState() {
    super.initState();
    Upgrader.latest(context);
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ScreenLocker.show(context);
    });
  }

  @override
  Widget build(BuildContext context) => OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          Context.orientation(orientation);

          return orientation == Orientation.portrait ? portrait() : landscape();
        },
      );

  Widget portrait() => Scaffold(
        body: body(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            item(Icons.home_outlined, S.of(context).home),
            item(Icons.copyright, 'Clivia'),
            item(Icons.person_outline, S.of(context).me),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: navigation,
          onTap: (int index) {
            setState(() {
              navigation = index;
            });
          },
        ),
      );

  Widget landscape() => Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigation,
              destinations: [
                destination(Icons.home_outlined, S.of(context).home),
                destination(Icons.copyright, 'Clivia'),
                destination(Icons.person_outline, S.of(context).me),
              ],
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: (int index) {
                setState(() {
                  navigation = index;
                });
              },
            ),
            Expanded(child: body()),
          ],
        ),
      );

  Widget body() {
    switch (navigation) {
      case 1:
        return Center(
          child: Column(
            children: const [
              Text('power by clivia-mobile'),
              Text('https://github.com/heisedebaise/clivia-mobile'),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
        );
      case 2:
        me ??= const MePage();
        return me!;
      default:
        return const Center(
          child: Text('coming soon'),
        );
    }
  }

  BottomNavigationBarItem item(IconData icon, String label) => BottomNavigationBarItem(
        icon: Icon(icon),
        label: label,
      );

  NavigationRailDestination destination(IconData icon, String label) => NavigationRailDestination(
        icon: Icon(icon),
        label: Text(label),
      );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) ScreenLocker.show(context);
  }
}
