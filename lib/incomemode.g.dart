// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incomemode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IncomemodeAdapter extends TypeAdapter<Income_mode> {
  @override
  final int typeId = 0;

  @override
  Income_mode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Income_mode(
      amount: fields[0] as int,
      note: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Income_mode obj) {
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

class ExpensemodeAdapter extends TypeAdapter<Expense_mode> {
  @override
  final int typeId = 1;

  @override
  Expense_mode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expense_mode(
      amount: fields[0] as int,
      note: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Expense_mode obj) {
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
      other is ExpensemodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
