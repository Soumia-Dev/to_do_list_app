import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selection_task_event.dart';
part 'selection_task_state.dart';

class SelectionTaskBloc extends Bloc<SelectionTaskEvent, SelectionTaskState> {
  SelectionTaskBloc() : super(SelectionTaskState(selectedTaskIds: {})) {
    on<ToggleTaskSelectionEvent>((event, emit) {
      final Set<int> current = state.selectedTaskIds;
      if (current.contains(event.taskId)) {
        current.remove(event.taskId);
      } else {
        current.add(event.taskId);
      }

      emit(SelectionTaskState(selectedTaskIds: current));
    });
    on<ClearTaskSelectionEvent>((event, emit) {
      emit(SelectionTaskState(selectedTaskIds: {}));
    });
  }
}
