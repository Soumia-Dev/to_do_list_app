import 'package:hive/hive.dart';
import 'package:to_do_list_app/domain/entities/task_entity.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final int? hiveId;
  @HiveField(1)
  final String hiveTitle;
  @HiveField(2)
  final String hiveDescription;
  @HiveField(3)
  final DateTime hiveCreatedAt;
  @HiveField(4)
  final DateTime hiveUpdatedAt;
  @HiveField(5)
  final bool hiveIsDone;

  TaskModel({
    this.hiveId,
    required this.hiveTitle,
    required this.hiveDescription,
    required this.hiveCreatedAt,
    required this.hiveUpdatedAt,
    required this.hiveIsDone,
  });

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      hiveTitle: entity.title,
      hiveDescription: entity.description,
      hiveCreatedAt: entity.createdAt,
      hiveUpdatedAt: entity.updatedAt,
      hiveIsDone: entity.isDone,
    );
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: hiveId,
      title: hiveTitle,
      description: hiveDescription,
      createdAt: hiveCreatedAt,
      updatedAt: hiveUpdatedAt,
      isDone: hiveIsDone,
    );
  }
}
