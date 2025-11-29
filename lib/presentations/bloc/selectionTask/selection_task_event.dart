part of 'selection_task_bloc.dart';

@immutable
sealed class SelectionTaskEvent {}

class ToggleTaskSelectionEvent extends SelectionTaskEvent {
  final int taskId;
  ToggleTaskSelectionEvent(this.taskId);
}

class ClearTaskSelectionEvent extends SelectionTaskEvent {}
