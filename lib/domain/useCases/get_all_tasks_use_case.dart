import 'package:dartz/dartz.dart';
import 'package:to_do_list_app/domain/repositories/task_repository.dart';

import '../entities/task_entity.dart';

class GetAllTasksUseCase {
  final TaskRepository taskRepository;
  GetAllTasksUseCase(this.taskRepository);

  Future<Either<String, List<TaskEntity>>> call() async {
    return await taskRepository.getAllTasks();
  }
}
