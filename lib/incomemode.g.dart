// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incomemode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IncomemodeAdapter extends TypeAdapter<Incomemode> {
  @override
  final int typeId = 0;

  @override
  Incomemode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Incomemode(
      amount: fields[0] as double,
      note: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Incomemode obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomemodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
