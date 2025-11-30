import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list_app/presentations/bloc/operationsTask/operations_task_bloc.dart'
    hide UpdateTasksEvent;
import 'package:to_do_list_app/presentations/bloc/selectionTask/selection_task_bloc.dart';

import '../../../domain/entities/task_entity.dart';
import '../../bloc/getTask/get_task_bloc.dart';

class HomeTasksWidgets {
  Widget buildDeleteIcon() =>
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
              valueColor: const AlwaysStoppedAnimation(Colors.greenAccent),
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
                  color: Colors.greenAccent,
                ),
              ),
              Text(
                "${doneTasks(state.tasks.toList())} of ${state.tasks.length} Task",
              ),
            ],
          ),
          SizedBox(width: 120),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/lottie/1.json"),
                const Expanded(
                  flex: 3,
                  child: Text("You have done all the task !👌"),
                ),
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
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 16,
                                            color: Colors.greenAccent,
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
                              color: Colors.green,
                              size: 40,
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
      onPressed: () => navigation(context, false, null),
      child: Icon(Icons.add, color: Colors.black),
    );
  }
}
