// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_list_main.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckListMainAdapter extends TypeAdapter<CheckListMain> {
  @override
  final int typeId = 0;

  @override
  CheckListMain read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckListMain(
      title: fields[0] as String,
    )
      ..isCompleted = fields[1] as bool
      ..details = (fields[2] as List)?.cast<CheckListDetails>();
  }

  @override
  void write(BinaryWriter writer, CheckListMain obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.isCompleted)
      ..writeByte(2)
      ..write(obj.details);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckListMainAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
