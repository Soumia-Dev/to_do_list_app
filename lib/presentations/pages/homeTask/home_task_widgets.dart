import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/entities/task_entity.dart';
import '../../bloc/getTask/get_task_bloc.dart';
import '../../bloc/operationsTask/operations_task_bloc.dart';
import '../../bloc/selectionTask/selection_task_bloc.dart';

class HomeTasksWidgets {
  Widget
  buildDeleteIcon() => BlocBuilder<SelectionTaskBloc, SelectionTaskState>(
    builder: (context, state) {
      return state.selectedTaskIds.isEmpty
          ? SizedBox.shrink()
          : IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Delete Tasks!"),
                      content: const Text(
                        "Are you sure you want to delete the selected task(s)?",
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                );

                if (confirm == true) {
                  context.read<OperationsTaskBloc>().add(
                    DeleteTasksEvent(ids: state.selectedTaskIds),
                  );
                  context.read<GetTaskBloc>().add(RefreshTasksEvent());
                  context.read<SelectionTaskBloc>().add(
                    ClearTaskSelectionEvent(),
                  );
                }
              },
            );
    },
  );

  Widget analyseTask(
    Function doneTasks,
    Function valueIndicator,
    TaskLoadedState state,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 30),
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black38,
                  value:
                      doneTasks(state.tasks.toList()) /
                      valueIndicator(state.tasks.toList()),
                  valueColor: AlwaysStoppedAnimation(Colors.lightBlue.shade300),
                ),
              ),
              const SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Tasks",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.lightBlue.shade300,
                    ),
                  ),
                  Text(
                    "${doneTasks(state.tasks.toList())} of ${state.tasks.length} Task",
                  ),
                ],
              ),
            ],
          ),
          buildDeleteIcon(),
        ],
      ),
    );
  }

  Widget buildBody(
    Function(BuildContext, bool, TaskEntity?) onNavigation,
    TaskLoadedState state,
  ) {
    return state.tasks.isEmpty
        ? Expanded(
            child: Column(
              children: [
                Lottie.asset("assets/lottie/done.json"),
                Text("You have done all the task !👌"),
              ],
            ),
          )
        : Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return BlocBuilder<SelectionTaskBloc, SelectionTaskState>(
                  builder: (context, state) {
                    final isSelected = state.selectedTaskIds.contains(task.id);
                    return Stack(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeIn,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
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
                                ? Colors.lightBlue.shade100
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
                                Expanded(
                                  child: Column(
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
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 16,
                                            color: Colors.lightBlue.shade600,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            DateFormat(
                                              'dd MMM yyyy – HH:mm',
                                            ).format(task.createdAt),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (task.isDone)
                          Positioned(
                            bottom: 10,
                            right: 20,
                            child: Text(
                              DateFormat(
                                'dd-MM-yyyy – HH:mm',
                              ).format(task.doneAt!),
                            ),
                          ),
                        if (task.isDone)
                          Positioned(
                            top: -10,
                            right: 10,
                            child: Icon(
                              Icons.done,
                              color: Colors.lightBlue.shade600,
                              size: 50,
                            ),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          );
  }

  Widget buildFloatingBtn(
    BuildContext context,
    Function(BuildContext, bool, TaskEntity?) navigation,
  ) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () => navigation(context, false, null),
      child: Icon(Icons.add, color: Colors.lightBlueAccent),
    );
  }
}
