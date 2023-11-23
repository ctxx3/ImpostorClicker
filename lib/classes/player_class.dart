import 'character_class.dart';
import 'impostor_class.dart';

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
