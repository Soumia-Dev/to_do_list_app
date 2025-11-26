part of 'operations_task_bloc.dart';

@immutable
sealed class OperationsTaskState {}

final class OperationsTaskInitial extends OperationsTaskState {}

final class LoadingOperationState extends OperationsTaskState {}

final class SuccessfulOperation extends OperationsTaskState {
  final String successfulMessage;
  SuccessfulOperation({required this.successfulMessage});
}

final class ErrorOperation extends OperationsTaskState {
  final String errorMessage;
  ErrorOperation({required this.errorMessage});
}
