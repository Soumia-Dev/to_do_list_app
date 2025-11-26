part of 'get_task_bloc.dart';

@immutable
sealed class GetTaskState {}

final class TaskInitialState extends GetTaskState {}

final class TaskLoadingState extends GetTaskState {}

final class TaskLoadedState extends GetTaskState {
  final List<TaskEntity> tasks;
  TaskLoadedState({required this.tasks});
}

final class TaskErrorState extends GetTaskState {
  final String messageError;
  TaskErrorState({required this.messageError});
}
