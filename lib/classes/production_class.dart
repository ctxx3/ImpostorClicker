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