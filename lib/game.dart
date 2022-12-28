import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:testapk/ImpostorClass.dart';

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
  late final List<Impostor> impostors;

  Game() {}

  Future<bool> init() async {
    List<Impostor> temp = [];
    dynamic impostorJson = await readEncryptedJson('assets/impostors.data');
    for (var i = 0; i < impostorJson.length; i++) {
      temp.add(Impostor.fromJSON(i, impostorJson[i]));
    }
    impostors = temp;

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

class Player {
  String username;
  num coins;
  int playerLevel;
  num playerxp;
  int selectedImpostor;
  List<Character> impostors;

  Player(
      {this.username = 'player',
      this.coins = .0,
      this.playerLevel = 1,
      this.playerxp = .0,
      this.selectedImpostor = 0,
      this.impostors = const []});

  factory Player.fromJSON(List<Impostor> impostors, dynamic json) {
    List<Character> temp = [];
    for (var i in json['impostors']) {
      temp.add(Character(impostors[i['baseId']], i['name'],
          level: i['level'], exp: i['exp'], stars: i['stars']));
    }
    return Player(
        username: json['username'],
        coins: json['coins'],
        playerLevel: json['playerLevel'],
        playerxp: json['playerxp'],
        selectedImpostor: json['selectedImpostor'],
        impostors: temp);
  }

  dynamic toJSON() => {
        'username': username,
        'coins': coins,
        'playerLevel': playerLevel,
        'playerxp': playerxp,
        'selectedImpostor': selectedImpostor,
        'impostors': List.from(impostors.map((element) => element.toJSON()))
      };
}
