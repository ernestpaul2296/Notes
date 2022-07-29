// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TextStylePropAdapter extends TypeAdapter<TextStyleProp> {
  @override
  final int typeId = 3;

  @override
  TextStyleProp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TextStyleProp(
      fontSize: fields[0] as double?,
      colorCode: fields[4] as int,
      textItalics: fields[2] as bool,
      textThinkness: fields[1] as bool,
      textUnderline: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TextStyleProp obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fontSize)
      ..writeByte(1)
      ..write(obj.textThinkness)
      ..writeByte(2)
      ..write(obj.textItalics)
      ..writeByte(3)
      ..write(obj.textUnderline)
      ..writeByte(4)
      ..write(obj.colorCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextStylePropAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
