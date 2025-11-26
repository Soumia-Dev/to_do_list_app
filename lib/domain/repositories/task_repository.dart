import 'package:dartz/dartz.dart';
import 'package:to_do_list_app/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<Either<String, List<TaskEntity>>> getAllTasks();
  Future<Either<String, Unit>> addTask(TaskEntity taskEntity);
  Future<Either<String, Unit>> updateTask(TaskEntity taskEntity);
  Future<Either<String, Unit>> deleteTask(int id);
}
