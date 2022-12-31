import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testapk/impostor_view.dart';
import 'package:testapk/game.dart';
import 'package:testapk/main_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color(0x00000000)));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(backgroundColor: Colors.black),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late final AnimationController _controller;
  late Game game;
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
    game = Game();
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
  FutureBuilder body() {
    return FutureBuilder(
        future: game.init(),
        builder: (context, snapshot) {
          if (loaded || snapshot.hasData) {
            loaded = true;
            return Stack(
              children: [
                TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const ClipRect(child: MainGame()),
                      template("LMAO 2", Colors.indigo),
                      template("LMAO 3", Colors.green),
                      template("LMAO 4", Colors.purple),
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
          } else {
            return const Text("Loading");
          }
        });
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
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          backgroundColor: const Color(0xa0000000),
          splashSpeedInMilliseconds: 200,
          inactiveColor: const Color(0xff808080),
          activeColor: const Color(0xffffffff),
          onTap: (index) => {
                _tabController.animateTo(index),
                setState(() => {
                      _bottomNavIndex = index,
                    }),
              }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
