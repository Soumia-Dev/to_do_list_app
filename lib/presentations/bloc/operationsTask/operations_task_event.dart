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

class DoneTaskEvent extends OperationsTaskEvent {
  final TaskEntity taskEntity;
  final String refreshState;
  DoneTaskEvent({required this.taskEntity, required this.refreshState});
}

class DeleteTasksEvent extends OperationsTaskEvent {
  final Set<int> ids;
  DeleteTasksEvent({required this.ids});
}
