// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_keys.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlogApiBoxAdapter extends TypeAdapter<BlogApiBox> {
  @override
  final int typeId = 1;

  @override
  BlogApiBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BlogApiBox(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BlogApiBox obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.hashApiKey)
      ..writeByte(1)
      ..write(obj.mediumApiKey)
      ..writeByte(2)
      ..write(obj.devToApiKey)
      ..writeByte(3)
      ..write(obj.hashUserId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlogApiBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
