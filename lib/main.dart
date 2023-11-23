import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:impostor_clicker/views/impostor_view.dart';
import 'package:impostor_clicker/classes/game_class.dart';
import 'package:impostor_clicker/views/main_view.dart';

import 'views/lootbox_view.dart';
import 'views/shop_view.dart';
import 'views/user_view.dart';

late Game game;
Future<void> main() async {
  // runApp(  DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(), // Wrap your app
  // ),);
  game = Game();
  await game.init();
  runApp(const MyApp());
}

class SaveAdapter {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color(0x00000000)));
    return MaterialApp(
      title: 'Impostor Clicker',
      theme: ThemeData(colorScheme: const ColorScheme.dark()),
      home: const MainPage(),
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late final AnimationController _controller;
  int currentSelected = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      value: 0,
    );
    _tabController = TabController(vsync: this, length: 4);
  }

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 1),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  ));
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget template(String text, Color color) {
    return Container(
      color: color,
      child: Center(
          child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'SansPro',
          fontSize: 24,
        ),
      )),
    );
  }

  bool panelOpen = false;
  bool loaded = false;
  Stack body() {
    return Stack(
      children: [
        TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ClipRect(child: MainGame()),
              ClipRect(child: ShopView()),
              ClipRect(child: LootboxView(game: game)),
              ClipRect(child: UserView()),
            ]),
        SlideTransition(
          position: _offsetAnimation,
          child: ClipRect(
              child: ImpostorView(
            game: game,
          )),
        ),
      ],
    );
  }

  int _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (!panelOpen) {
              _controller.forward(from: _controller.value);
            } else {
              _controller.reverse(from: _controller.value);
            }
            setState(() {});
            panelOpen = !panelOpen;
          });
        },
        elevation: 4.0,
        shape: const CircleBorder(),
        child: (panelOpen)
            ? const Icon(FontAwesomeIcons.chevronDown)
            : const Icon(FontAwesomeIcons.chevronUp),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: const [
            FontAwesomeIcons.rocket,
            FontAwesomeIcons.shop,
            FontAwesomeIcons.ghost,
            FontAwesomeIcons.solidCircleUser
          ],
          //height: 15,
          safeAreaValues:
              const SafeAreaValues(left: false, right: false, bottom: false),
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          backgroundColor: const Color.fromARGB(159, 0, 0, 0),
          splashSpeedInMilliseconds: 200,
          inactiveColor: const Color(0xff808080),
          activeColor: const Color(0xffffffff),
          onTap: (index) => {
                _tabController.animateTo(index),
                setState(
                  () => _bottomNavIndex = index,
                ),
              }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
