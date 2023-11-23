import 'package:hive/hive.dart';

part 'save.g.dart';

@HiveType(typeId: 1)
class Save {
  Save({required this.name, required this.age});
  @HiveField(0)
  String name = "default";

  @HiveField(1)
  int age;
}