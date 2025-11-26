import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_list_app/domain/entities/task_entity.dart';
import 'package:to_do_list_app/domain/useCases/add_task_use_case.dart';
import 'package:to_do_list_app/domain/useCases/delete_task_use_case.dart';
import 'package:to_do_list_app/domain/useCases/get_all_tasks_use_case.dart';
import 'package:to_do_list_app/domain/useCases/update_task_use_case.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasksUseCase getAllTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  TaskBloc({
    required this.getAllTasksUseCase,
    required this.addTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
  }) : super(TaskInitialState()) {
    on<GetTasksEvent>((event, emit) async {
      emit(TaskLoadingState());
      final tasks = await getAllTasksUseCase();
      tasks.fold(
        (error) {
          emit(TaskErrorState(messageError: error));
        },
        (tasks) {
          TaskLoadedState(tasks: tasks);
        },
      );
    });
  }
}
