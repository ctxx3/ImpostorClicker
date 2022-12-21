import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testapk/impostor_view.dart';
import 'package:testapk/progressbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color(0x00000000)));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
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
  int currentSelected = 0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      value: 1,
    );

    _tabController = TabController(vsync: this, length: 5)
      ..addListener(() {
        if (_tabController.indexIsChanging) {
          if (_tabController.index != currentSelected) {
            _controller.reverse(from: 1).then((value) => {
                  currentSelected = _tabController.index,
                  _controller.forward(from: 0)
                });
          }

          setState(() {});
        }
      });
    setState(() {
      _tabController.index = 2;
    });
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

  Widget _tabBarView() {
    return SlideTransition(
      position: _offsetAnimation,
      child: const [
        Center(child: Text("LMAO1")),
        Center(child: Text("LMAO2")),
        ImpostorView(),
        Center(child: Text("LMAO3")),
        Center(child: Text("LMAO4")),
      ][currentSelected],
    );
  }

  int _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            Center(child: Text("LMAO1")),
            Center(child: Text("LMAO2")),
            Center(child: Text("LMAO3")),
            Center(child: Text("LMAO4")),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_tabController.index != 2) {
            _tabController.animateTo(2);
          } else {
            _tabController.animateTo(0);
          }
        },
        elevation: 4.0,
        child: const Icon(FontAwesomeIcons.chevronUp),
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
                _tabController.animateTo((index < 2) ? index : index + 1),
                setState(() => {
                      _bottomNavIndex = index,
                    }),
              }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
