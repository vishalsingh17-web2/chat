// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInfAdapter extends TypeAdapter<UserInf> {
  @override
  final int typeId = 0;

  @override
  UserInf read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInf(
      name: fields[2] as String,
      email: fields[0] as String,
      phone: fields[3] as String,
      image: fields[1] as String,
      uid: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserInf obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
