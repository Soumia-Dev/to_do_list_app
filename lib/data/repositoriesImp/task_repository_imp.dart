import 'package:dartz/dartz.dart';
import 'package:to_do_list_app/domain/entities/task_entity.dart';

import '../../domain/repositories/task_repository.dart';
import '../dataSource/task_local_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImp implements TaskRepository {
  final TaskLocalDataSource locale;

  TaskRepositoryImp({required this.locale});
  @override
  Future<Either<String, List<TaskEntity>>> getAllTasks() async {
    try {
      final tasks = await locale.getTasks();
      return Right(tasks.map((task) => task.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> addTask(TaskEntity taskEntity) async {
    try {
      final taskModel = TaskModel.fromEntity(taskEntity);
      await locale.addTask(taskModel);
      return Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> updateTask(TaskEntity taskEntity) async {
    try {
      final model = TaskModel.fromEntity(taskEntity);
      await locale.updateTask(model);
      return Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> deleteTask(Set<int> ids) async {
    try {
      await locale.deleteTask(ids);

      return Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
