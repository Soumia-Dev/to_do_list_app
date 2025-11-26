part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitialState extends TaskState {}

final class TaskLoadingState extends TaskState {}

final class TaskLoadedState extends TaskState {
  final List<TaskEntity> tasks;
  TaskLoadedState({required this.tasks});
}

final class TaskErrorState extends TaskState {
  final String messageError;
  TaskErrorState({required this.messageError});
}
