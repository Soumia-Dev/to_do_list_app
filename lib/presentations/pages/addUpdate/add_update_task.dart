import 'package:flutter/material.dart';
import 'package:to_do_list_app/domain/entities/task_entity.dart';

import 'add_update_task_widgets.dart';

class AddUpdateTask extends StatelessWidget {
  final bool isUpdate;
  final TaskEntity? taskEntity;
  final AddUpdateTaskWidgets addUpdateTaskWidgets = AddUpdateTaskWidgets();
  AddUpdateTask({super.key, required this.isUpdate, this.taskEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: addUpdateTaskWidgets.body(isUpdate, taskEntity),
    );
  }
}
