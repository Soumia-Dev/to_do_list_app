// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      hiveId: fields[0] as int?,
      hiveTitle: fields[1] as String,
      hiveDescription: fields[2] as String,
      hiveCreatedAt: fields[3] as DateTime,
      hiveDoneAt: fields[4] as DateTime?,
      hiveIsDone: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.hiveId)
      ..writeByte(1)
      ..write(obj.hiveTitle)
      ..writeByte(2)
      ..write(obj.hiveDescription)
      ..writeByte(3)
      ..write(obj.hiveCreatedAt)
      ..writeByte(4)
      ..write(obj.hiveDoneAt)
      ..writeByte(5)
      ..write(obj.hiveIsDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
