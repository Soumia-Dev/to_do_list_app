part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class GetTasksEvent extends TaskEvent {}

class AddTasksEvent extends TaskEvent {
  final TaskEntity taskEntity;
  AddTasksEvent({required this.taskEntity});
}

class UpdateTasksEvent extends TaskEvent {
  final TaskEntity taskEntity;
  UpdateTasksEvent({required this.taskEntity});
}

class DeleteTasksEvent extends TaskEvent {
  final int id;
  DeleteTasksEvent({required this.id});
}
