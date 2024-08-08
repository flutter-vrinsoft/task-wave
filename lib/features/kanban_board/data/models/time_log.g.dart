// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeLogAdapter extends TypeAdapter<TimeLog> {
  @override
  final int typeId = 3;

  @override
  TimeLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeLog(
      userId: fields[0] as String,
      taskId: fields[1] as String,
      startTime: fields[2] as DateTime,
      endTime: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TimeLog obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.taskId)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
