// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_list_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckListDetailsAdapter extends TypeAdapter<CheckListDetails> {
  @override
  final int typeId = 1;

  @override
  CheckListDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckListDetails(
      description: fields[0] as String,
      isDone: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CheckListDetails obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckListDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
