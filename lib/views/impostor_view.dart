import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:impostor_clicker/classes/game_class.dart';
import 'package:impostor_clicker/views/Components/topbar.dart';

class ImpostorView extends StatefulWidget {
  final Game game;
  const ImpostorView({super.key, required this.game});
  @override
  State<ImpostorView> createState() => ImpostorViewState();
}

class ImpostorViewState extends State<ImpostorView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int selectedIndex = 0;

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
                    image: AssetImage(
                        widget.game.player.impostors[selectedIndex].sprite))),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 42, sigmaY: 42),
                child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    color: Colors.black.withOpacity(.5),
                    child: SafeArea(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Column(
                              children: [
                                topBar(
                                    widget.game.player.impostors[selectedIndex]
                                        .level,
                                    widget.game.player.impostors[selectedIndex]
                                        .exp,
                                    100,
                                    Colors.cyan)
                              ],
                            )),
                        Flexible(
                          child: Image.asset(
                            widget.game.player.impostors[selectedIndex].sprite,
                          ),
                        ),
                        Container(
                            child: title(
                                widget
                                    .game.player.impostors[selectedIndex].name,
                                widget.game.tiers[widget
                                    .game.player.impostors[selectedIndex].tier],
                                widget
                                    .game.player.impostors[selectedIndex].stars,
                                const Color(0xffaa4261),
                                const Color.fromARGB(235, 211, 62, 86))),
                        Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0x2bffffff)))),
                            padding: const EdgeInsets.only(bottom: 5),
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
                        impostorList(
                            widget.game.player.impostors,
                            ((id) => {
                                  setState((() => {selectedIndex = id}))
                                })),
                      ],
                    ))))));
  }
}
