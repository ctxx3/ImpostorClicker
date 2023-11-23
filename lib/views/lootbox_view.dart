import 'package:flutter/material.dart';
import 'package:impostor_clicker/classes/save.dart';

import '../classes/game_class.dart';

class LootboxView extends StatefulWidget {
  final Game game;
  const LootboxView({super.key, required this.game});

  @override
  State<LootboxView> createState() => _LootboxViewState();
}

class _LootboxViewState extends State<LootboxView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;

  @override
  bool get wantKeepAlive => true;

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
    super.build(context);

    //Save text = widget.game.save.get('save');
    return const Scaffold(
        extendBody: true,
        backgroundColor: Color(0xff0b0c11),
        body: Center(child: Text("test")
            //TextField(onChanged: (value){widget.game.save.put('name',value);},)
            ));
  }
}
