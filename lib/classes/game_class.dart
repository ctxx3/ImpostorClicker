import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:impostor_clicker/classes/save.dart';
import 'impostor_class.dart';
import 'player_class.dart';

class Game {
  final List<String> tiers = [
    'Common',
    'Uncommon',
    'Rare',
    'Epic',
    'Legendary',
    'Astral'
  ];
  late Player player;
  late List<Impostor> impostors;
  late Box save;

  Game();

  Future<bool> init() async {

    //Load Save
    await Hive.initFlutter();
    save = await Hive.openBox('save');
    Hive.registerAdapter(SaveAdapter());

    //Load Impostor list
    List<Impostor> temp = [];
    dynamic impostorJson = await readEncryptedJson('assets/impostors.data');
    for (var i = 0; i < impostorJson.length; i++) {
      temp.add(Impostor.fromJSON(i, impostorJson[i]));
    }
    impostors = temp;

    //This won't do
    player = Player.fromJSON(impostors, await readJson('assets/player.json'));

    return true;
  }

  Future<dynamic> readJson(String path) async {
    final String response = await rootBundle.loadString(path);
    final data = await json.decode(response);
    return data;
  }

  Future<dynamic> readEncryptedJson(String path) async {
    final ByteData response = await rootBundle.load(path);
    final data = await json.decode(xor(response));
    return data;
  }

  String xor(ByteData data) {
    List<int> result = [];
    List<int> password = "susImpostor".codeUnits;
    List<int> bytes = data.buffer.asInt8List();
    for (int i = 0; i < bytes.length; i++) {
      result.add(bytes[i] ^ password[i % password.length]);
    }
    return const Utf8Decoder().convert(result);
  }
}