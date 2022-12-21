import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testapk/topbar.dart';

class ImpostorView extends StatefulWidget {
  const ImpostorView({Key? key}) : super(key: key);

  @override
  State<ImpostorView> createState() => ImpostorViewState();
}

class ImpostorViewState extends State<ImpostorView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
  }

  //2.3 dla 860
  //3.3 dla 720
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: const Color(0xff161923),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: .9,
                    scale:
                        -(1 / 140) * MediaQuery.of(context).size.height + 8.642,
                    fit: BoxFit.none,
                    alignment: const Alignment(0, -.95),
                    image: const AssetImage('assets/amogus.png'))),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 42, sigmaY: 42),
                child: Container(
                    color: Colors.black.withOpacity(.5),
                    child: SafeArea(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 5),
                            child: Column(
                              children: [topBar],
                            )),
                        Flexible(
                          child: Image.asset(
                            'assets/amogus.png',
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 5),
                            child: title("The Real Sus", "Mythic", 4)),
                        Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0x2bffffff)))),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 5),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ibutton(FontAwesomeIcons.fire, "ass"),
                                  ibutton(FontAwesomeIcons.leaf, "ass"),
                                  ibutton(
                                      FontAwesomeIcons.boltLightning, "ass"),
                                  ibutton(
                                      FontAwesomeIcons.accessibleIcon, "ass"),
                                  ibutton(FontAwesomeIcons.box, "ass")
                                ])),
                        impostorList(),
                      ],
                    ))))));
  }
}
