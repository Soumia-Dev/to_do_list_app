import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/presentations/bloc/operationsTask/operations_task_bloc.dart'
    hide UpdateTasksEvent;
import 'package:to_do_list_app/presentations/bloc/selectionTask/selection_task_bloc.dart';

import '../../../core/widgets.dart';
import '../../../domain/entities/task_entity.dart';
import '../../bloc/getTask/get_task_bloc.dart';

class HomeTasksWidgets {
  Widgets widgets = Widgets();
  AppBar buildAppbar() => AppBar(
    title: Text(
      'My Tasks',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
    ),
    actions: [
      BlocBuilder<SelectionTaskBloc, SelectionTaskState>(
        builder: (context, state) {
          return state.selectedTaskIds.isEmpty
              ? SizedBox.shrink()
              : IconButton(
                  onPressed: () {
                    context.read<OperationsTaskBloc>().add(
                      DeleteTasksEvent(ids: state.selectedTaskIds),
                    );
                    context.read<GetTaskBloc>().add(UpdateTasksEvent());
                    context.read<SelectionTaskBloc>().add(
                      ClearTaskSelectionEvent(),
                    );
                  },
                  icon: Icon(Icons.delete, color: Colors.redAccent),
                );
        },
      ),
    ],
  );
  Widget buildBody(Function(BuildContext, bool, TaskEntity?) onNavigation) {
    return BlocListener<OperationsTaskBloc, OperationsTaskState>(
      listener: (context, state) {
        if (state is SuccessfulOperation) {
          widgets.buildSnackBar(context, state.successMessage, Colors.green);
          context.read<GetTaskBloc>().add(UpdateTasksEvent());
        } else if (state is ErrorOperation) {
          widgets.buildSnackBar(context, state.errorMessage, Colors.redAccent);
        }
      },
      child: BlocBuilder<GetTaskBloc, GetTaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return widgets.buildLoading();
          } else if (state is TaskLoadedState) {
            return state.tasks.isEmpty
                ? Center(child: Text("there is no tasks"))
                : ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final task = state.tasks[index];
                      return BlocBuilder<SelectionTaskBloc, SelectionTaskState>(
                        builder: (context, state) {
                          final isSelected = state.selectedTaskIds.contains(
                            task.id,
                          );
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            curve: Curves.easeIn,
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.red
                                    : Colors.grey.shade200,
                                width: 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              color: isSelected
                                  ? Colors.red.shade50
                                  : task.isDone
                                  ? Colors.greenAccent.shade100
                                  : Colors.grey.shade50,
                            ),
                            child: InkWell(
                              onLongPress: () {
                                context.read<SelectionTaskBloc>().add(
                                  ToggleTaskSelectionEvent(task.id!),
                                );
                              },
                              onTap: () => onNavigation(context, true, task),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: isSelected,
                                    onChanged: (v) {
                                      context.read<SelectionTaskBloc>().add(
                                        ToggleTaskSelectionEvent(task.id!),
                                      );
                                    },
                                    activeColor: Colors.red,
                                  ),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        task.title,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          decoration: task.isDone
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                      Text(
                                        task.description,
                                        style: TextStyle(
                                          decoration: task.isDone
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                size: 16,
                                                color: Colors.white70,
                                              ),
                                              SizedBox(width: 6),
                                              Text(task.createdAt.toString()),
                                            ],
                                          ),
                                          if (task.isDone)
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.done,
                                                  size: 16,
                                                  color: Colors.white70,
                                                ),
                                                SizedBox(width: 6),
                                                Text(task.doneAt.toString()),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (task.isDone)
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                      size: 40,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
          } else if (state is TaskErrorState) {
            return ListView(
              children: [
                const SizedBox(height: 200),
                Center(child: Center(child: Text(state.messageError))),
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget buildFloatingBtn(
    BuildContext context,
    Function(BuildContext, bool, TaskEntity?) navigation,
  ) {
    return FloatingActionButton(
      onPressed: () => navigation(context, false, null),
      child: Icon(Icons.add),
    );
  }
}
