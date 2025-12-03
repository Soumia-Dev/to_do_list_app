import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/task_entity.dart';
import '../../../domain/useCases/add_task_use_case.dart';
import '../../../domain/useCases/delete_task_use_case.dart';
import '../../../domain/useCases/update_task_use_case.dart';

part 'operations_task_event.dart';
part 'operations_task_state.dart';

class OperationsTaskBloc
    extends Bloc<OperationsTaskEvent, OperationsTaskState> {
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  OperationsTaskBloc({
    required this.addTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
  }) : super(OperationsTaskInitial()) {
    on<AddTasksEvent>((event, emit) async {
      await handleOperation(
        emit: emit,
        operation: () => addTaskUseCase(event.taskEntity),
        successMsg: "Task added successfully",
      );
    });
    on<UpdateTasksEvent>((event, emit) async {
      await handleOperation(
        emit: emit,
        operation: () => updateTaskUseCase(event.taskEntity),
        successMsg: "Task updated successfully",
      );
    });
    on<DeleteTasksEvent>((event, emit) async {
      await handleOperation(
        emit: emit,
        operation: () => deleteTaskUseCase(event.ids),
        successMsg: "Task deleted successfully",
      );
    });
    on<DoneTaskEvent>((event, emit) async {
      await handleOperation(
        emit: emit,
        operation: () => updateTaskUseCase(event.taskEntity),
        successMsg: event.refreshState,
      );
    });
  }

  Future<void> handleOperation({
    required Emitter<OperationsTaskState> emit,
    required Future<Either<String, Unit>> Function() operation,
    required String successMsg,
  }) async {
    emit(LoadingOperationState());
    try {
      final result = await operation();
      if (result.isLeft()) {
        emit(ErrorOperation(errorMessage: "please try again !"));
      } else {
        emit(SuccessfulOperation(successMessage: successMsg));
      }
    } catch (e) {
      emit(ErrorOperation(errorMessage: e.toString()));
    }
  }
}
