import 'package:flutter/material.dart';
import 'package:to_do_list_app/domain/entities/task_entity.dart';

class AddUpdateTask extends StatelessWidget {
  final bool isUpdate;
  final TaskEntity? taskEntity;
  const AddUpdateTask({super.key, required this.isUpdate, this.taskEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isUpdate ? "Update Task" : "Add Task")),
    );
  }
}
