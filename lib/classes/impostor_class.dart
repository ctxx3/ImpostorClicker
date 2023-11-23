import 'production_class.dart';

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

