class TaskEntity {
  final String? id;
  final String title;
  final String subtitle;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isDone;

  const TaskEntity({
    this.id,
    required this.title,
    required this.subtitle,
    required this.createdAt,
    this.updatedAt,
    required this.isDone,
  });
}
