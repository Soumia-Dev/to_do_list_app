import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_list_app/domain/entities/task_entity.dart';
import 'package:to_do_list_app/domain/useCases/get_all_tasks_use_case.dart';

part 'get_task_event.dart';
part 'get_task_state.dart';

class GetTaskBloc extends Bloc<GetTaskEvent, GetTaskState> {
  final GetAllTasksUseCase getAllTasksUseCase;

  GetTaskBloc({required this.getAllTasksUseCase}) : super(TaskInitialState()) {
    on<GetTasksEvent>((event, emit) async {
      emit(TaskLoadingState());
      handleOperation(emit: emit);
    });
    on<RefreshTasksEvent>((event, emit) async {
      handleOperation(emit: emit);
    });
  }
  Future<void> handleOperation({required Emitter<GetTaskState> emit}) async {
    final tasks = await getAllTasksUseCase();
    tasks.fold(
      (error) {
        emit(TaskErrorState(messageError: error));
      },
      (tasks) {
        emit(TaskLoadedState(tasks: tasks));
      },
    );
  }
}
