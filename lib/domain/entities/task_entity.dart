class TaskEntity {
  final int? id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? doneAt;
  final bool isDone;

  const TaskEntity({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.doneAt,
    required this.isDone,
  });

  TaskEntity copyWith({
    String? title,
    String? description,
    DateTime? doneAt,
    bool? isDone,
  }) {
    return TaskEntity(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt,
      doneAt: doneAt ?? this.doneAt,
      isDone: isDone ?? this.isDone,
    );
  }

  TaskEntity toggleDone() {
    return copyWith(isDone: !isDone, doneAt: isDone ? null : DateTime.now());
  }
}
