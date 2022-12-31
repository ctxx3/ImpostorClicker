import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainGame extends StatefulWidget {
  const MainGame({super.key});

  @override
  State<MainGame> createState() => _MainGameState();
}

class _MainGameState extends State<MainGame>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: const Color(0xff0b0c11),
        body: Stack(children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 350),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: ShaderMask(
                child: SvgPicture.asset('assets/ui/platform.svg',
                    alignment: Alignment.bottomCenter),
                shaderCallback: (Rect bounds) {
                  return (const LinearGradient(
                          transform: GradientRotation(-12),
                          colors: <Color>[Colors.red, Colors.blue]))
                      .createShader(bounds);
                },
              )),
          ClipRect(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 180, sigmaY: 180),
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 350),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: ShaderMask(
                  child: SvgPicture.asset('assets/ui/platform.svg',
                      alignment: Alignment.bottomCenter),
                  shaderCallback: (Rect bounds) {
                    return (const LinearGradient(
                            transform: GradientRotation(-12),
                            colors: <Color>[Colors.red, Colors.blue]))
                        .createShader(bounds);
                  },
                )),
          ))
        ]));
  }
}
