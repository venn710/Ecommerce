// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Hiveaddress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ADDRESSAdapter extends TypeAdapter<ADDRESS> {
  @override
  final int typeId = 0;

  @override
  ADDRESS read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ADDRESS()
      ..hno = fields[0] as String
      ..state = fields[1] as String
      ..district = fields[2] as String
      ..mobileno = fields[3] as String
      ..name = fields[4] as String
      ..village = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, ADDRESS obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.hno)
      ..writeByte(1)
      ..write(obj.state)
      ..writeByte(2)
      ..write(obj.district)
      ..writeByte(3)
      ..write(obj.mobileno)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.village);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ADDRESSAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
