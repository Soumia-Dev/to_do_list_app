class TaskEntity {
  final String? id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isDone;

  const TaskEntity({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    required this.isDone,
  });
}
