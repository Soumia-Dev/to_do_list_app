import 'package:dartz/dartz.dart';
import 'package:to_do_list_app/domain/entities/task_entity.dart';
import 'package:to_do_list_app/domain/repositories/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository taskRepository;
  AddTaskUseCase(this.taskRepository);
  Future<Either<String, Unit>> call(TaskEntity taskEntity) async {
    return await taskRepository.addTask(taskEntity);
  }
}
