import 'impostor_class.dart';

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
