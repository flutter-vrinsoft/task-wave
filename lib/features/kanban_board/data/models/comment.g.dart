// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentAdapter extends TypeAdapter<Comment> {
  @override
  final int typeId = 2;

  @override
  Comment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Comment(
      userId: fields[0] as String,
      taskId: fields[1] as String,
      content: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Comment obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.taskId)
      ..writeByte(2)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CommentAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
