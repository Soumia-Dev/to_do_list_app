part of 'operations_task_bloc.dart';

@immutable
sealed class OperationsTaskEvent {}

class AddTasksEvent extends OperationsTaskEvent {
  final TaskEntity taskEntity;
  AddTasksEvent({required this.taskEntity});
}

class UpdateTasksEvent extends OperationsTaskEvent {
  final TaskEntity taskEntity;
  UpdateTasksEvent({required this.taskEntity});
}

class DeleteTasksEvent extends OperationsTaskEvent {
  final Set<int> ids;
  DeleteTasksEvent({required this.ids});
}
