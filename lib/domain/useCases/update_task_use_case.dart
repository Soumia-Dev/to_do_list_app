import 'package:dartz/dartz.dart';

import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository taskRepository;
  UpdateTaskUseCase(this.taskRepository);
  Future<Either<String, Unit>> call(TaskEntity taskEntity) async {
    return await taskRepository.updateTask(taskEntity);
  }
}
