import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'operations_task_event.dart';
part 'operations_task_state.dart';

class OperationsTaskBloc
    extends Bloc<OperationsTaskEvent, OperationsTaskState> {
  OperationsTaskBloc() : super(OperationsTaskInitial()) {
    on<OperationsTaskEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
