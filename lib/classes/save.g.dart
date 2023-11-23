// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveAdapter extends TypeAdapter<Save> {
  @override
  final int typeId = 1;

  @override
  Save read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Save(
      name: fields[0] as String,
      age: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Save obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
