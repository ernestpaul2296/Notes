// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteContentAdapter extends TypeAdapter<NoteContent> {
  @override
  final int typeId = 2;

  @override
  NoteContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteContent(
      noteContentType: fields[0] as String,
      positionX: fields[1] as double,
      positionY: fields[2] as double,
      height: fields[3] as double,
      width: fields[4] as double,
      color: fields[5] as int,
      fontSize: fields[6] as double?,
      noteContentId: fields[7] as String,
      borderColor: fields[8] as int,
      text: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteContent obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.noteContentType)
      ..writeByte(1)
      ..write(obj.positionX)
      ..writeByte(2)
      ..write(obj.positionY)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.width)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.fontSize)
      ..writeByte(7)
      ..write(obj.noteContentId)
      ..writeByte(8)
      ..write(obj.borderColor)
      ..writeByte(9)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
