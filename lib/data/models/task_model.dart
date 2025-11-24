import 'package:to_do_list_app/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    super.id,
    required super.title,
    required super.description,
    required super.createdAt,
    required super.isDone,
  });
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: json['createdAt'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'isDone': isDone,
    };
  }
}
