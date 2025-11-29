import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/domain/entities/task_entity.dart';
import 'package:to_do_list_app/presentations/bloc/getTask/get_task_bloc.dart';
import 'package:to_do_list_app/presentations/pages/addUpdate/add_update_task.dart';
import 'package:to_do_list_app/presentations/pages/homeTask/home_task_widgets.dart';

class HomeTasks extends StatelessWidget {
  final HomeTasksWidgets homeTasksWidgets = HomeTasksWidgets();
  HomeTasks({super.key});
  Future<void> onRefresh(BuildContext context) async {
    BlocProvider.of<GetTaskBloc>(context).add(UpdateTasksEvent());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeTasksWidgets.buildAppbar(),
      body: RefreshIndicator(
        color: Colors.blue,
        onRefresh: () => onRefresh(context),
        child: homeTasksWidgets.buildBody(navigationToAddOrUpdate),
      ),
      floatingActionButton: homeTasksWidgets.buildFloatingBtn(
        context,
        navigationToAddOrUpdate,
      ),
    );
  }
}
