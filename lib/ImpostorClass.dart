import 'dart:ffi';

class Production {
  final num coins;
  final num exp;
  final num lootChests;
  Production(this.coins, this.exp, this.lootChests);

  Production.fromJSON(dynamic json)
      : coins = json['coins'],
        exp = json['exp'],
        lootChests = json['loot_chests'];

  @override
  String toString() {
    return '{$coins, $exp, $lootChests}';
  }
}

class Impostor {
  final int id;
  final String defaultName;
  final String sprite;
  final int tier;
  final num lvlMultiplier;
  final num statMultiplier;
  final Production production;
  final Production afkProduction;

  Impostor(
      this.id,
      this.defaultName,
      this.sprite,
      this.tier,
      this.lvlMultiplier,
      this.statMultiplier,
      this.production,
      this.afkProduction);

  Impostor.fromJSON(this.id, dynamic json)
      : defaultName = json['default_name'],
        sprite = json['sprite'],
        tier = json['tier'],
        lvlMultiplier = json['level_multiplier'],
        statMultiplier = json['stat_multiplier'],
        production = Production.fromJSON(json['production']),
        afkProduction = Production.fromJSON(json['afk_production']);

  @override
  String toString() {
    return '{$id,$defaultName, $sprite, $tier, ${production.toString()}, ${afkProduction.toString()}';
  }
}

class Character extends Impostor {
  late String name;
  int level;
  num exp;
  int stars;

  Character(Impostor base, this.name,
      {this.level = 1, this.exp = .0, this.stars = 0})
      : super(
            base.id,
            base.defaultName,
            base.sprite,
            base.tier,
            base.lvlMultiplier,
            base.statMultiplier,
            base.production,
            base.afkProduction);

  dynamic toJSON() =>
      {'name': name, 'level': level, 'exp': exp, 'stars': stars, 'baseId': id};
}
