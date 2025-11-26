class TaskEntity {
  final int? id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDone;

  const TaskEntity({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isDone,
  });

  TaskEntity copyWith({String? title, String? description, bool? isDone}) {
    return TaskEntity(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      isDone: isDone ?? this.isDone,
    );
  }

  TaskEntity toggleDone() {
    return copyWith(isDone: !isDone);
  }
}
