import 'package:dartz/dartz.dart';

import '../repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository taskRepository;
  DeleteTaskUseCase(this.taskRepository);
  Future<Either<String, Unit>> call(int id) async {
    return await taskRepository.deleteTask(id);
  }
}
