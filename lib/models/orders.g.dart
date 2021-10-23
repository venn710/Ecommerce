// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ORDERSAdapter extends TypeAdapter<ORDERS> {
  @override
  final int typeId = 2;

  @override
  ORDERS read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ORDERS()
      ..usermail = fields[0] as String
      ..image = fields[1] as String
      ..title = fields[2] as String
      ..desc = fields[3] as String
      ..id = fields[4] as String
      ..brand = fields[5] as String
      ..unique_id = fields[6] as String
      ..price = fields[7] as int
      ..size = fields[8] as int
      ..quant = fields[9] as int;
  }

  @override
  void write(BinaryWriter writer, ORDERS obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.usermail)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.desc)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.brand)
      ..writeByte(6)
      ..write(obj.unique_id)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.size)
      ..writeByte(9)
      ..write(obj.quant);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ORDERSAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
