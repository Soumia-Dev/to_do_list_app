import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list_app/data/dataSource/task_local_data_source_imp.dart';
import 'package:to_do_list_app/data/repositoriesImp/task_repository_imp.dart';
import 'package:to_do_list_app/domain/useCases/get_all_tasks_use_case.dart';
import 'package:to_do_list_app/presentations/bloc/getTask/get_task_bloc.dart';
import 'package:to_do_list_app/presentations/bloc/operationsTask/operations_task_bloc.dart';

import '../data/dataSource/task_local_data_source.dart';
import '../data/models/task_model.dart';
import '../domain/repositories/task_repository.dart';
import '../domain/useCases/add_task_use_case.dart';
import '../domain/useCases/delete_task_use_case.dart';
import '../domain/useCases/update_task_use_case.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //Bloc -----------------------------------------------------------------------
  sl.registerLazySingleton(() => GetTaskBloc(getAllTasksUseCase: sl()));
  sl.registerLazySingleton(
    () => OperationsTaskBloc(
      addTaskUseCase: sl(),
      updateTaskUseCase: sl(),
      deleteTaskUseCase: sl(),
    ),
  );

  // UseCases ------------------------------------------------------------------
  sl.registerLazySingleton(() => GetAllTasksUseCase(sl()));
  sl.registerLazySingleton(() => AddTaskUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));

  // Repository ----------------------------------------------------------------
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImp(locale: sl()),
  );

  //Hive -----------------------------------------------------------------------
  final box = await Hive.openBox<TaskModel>("tasks");
  sl.registerLazySingleton<Box<TaskModel>>(() => box);

  // Data Sources --------------------------------------------------------------
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImp(box: sl()),
  );
}
