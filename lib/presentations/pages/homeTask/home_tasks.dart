import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/domain/entities/task_entity.dart';
import 'package:to_do_list_app/presentations/bloc/getTask/get_task_bloc.dart';
import 'package:to_do_list_app/presentations/pages/addUpdate/add_update_task.dart';
import 'package:to_do_list_app/presentations/pages/homeTask/home_task_widgets.dart';

import '../../../core/widgets.dart';

class HomeTasks extends StatelessWidget {
  final HomeTasksWidgets homeTasksWidgets = HomeTasksWidgets();
  final Widgets widgets = Widgets();

  HomeTasks({super.key});
  Future<void> onRefresh(BuildContext context) async {
    BlocProvider.of<GetTaskBloc>(context).add(RefreshTasksEvent());
  }

  void navigationToAddOrUpdate(
    BuildContext context,
    bool isUpdate,
    TaskEntity? taskEntity,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddUpdateTask(
          isUpdate: isUpdate,
          taskEntity: taskEntity,
          //    isUpdatePost: false,
        ),
      ),
    );
  }

  int doneTasks(List<TaskEntity> tasks) {
    int i = 0;
    for (var task in tasks) {
      if (task.isDone) {
        i = ++i;
      }
    }
    return i;
  }

  int valueIndicator(List<TaskEntity> tasks) {
    if (tasks.isEmpty) {
      return 1;
    }
    return tasks.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: homeTasksWidgets.buildFloatingBtn(
        context,
        navigationToAddOrUpdate,
      ),
      body: RefreshIndicator(
        color: Colors.blue,
        onRefresh: () => onRefresh(context),
        child: BlocBuilder<GetTaskBloc, GetTaskState>(
          builder: (context, state) {
            if (state is TaskLoadingState) {
              return widgets.buildLoading();
            } else if (state is TaskLoadedState) {
              return Column(
                children: [
                  SizedBox(height: 100),
                  homeTasksWidgets.analyseTask(
                    doneTasks,
                    valueIndicator,
                    state,
                  ),
                  const Divider(thickness: 2, indent: 100, endIndent: 5),
                  homeTasksWidgets.buildBody(navigationToAddOrUpdate, state),
                ],
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
      ),
    );
  }
}
