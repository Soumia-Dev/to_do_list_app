import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/domain/entities/task_entity.dart';

import '../../bloc/operationsTask/operations_task_bloc.dart';

class FormTask extends StatefulWidget {
  final bool isUpdate;
  final TaskEntity? taskEntity;
  const FormTask({super.key, required this.isUpdate, required this.taskEntity});
  @override
  State<FormTask> createState() => _FormTaskState();
}

class _FormTaskState extends State<FormTask> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdate) {
      titleController.text = widget.taskEntity!.title;
      descriptionController.text = widget.taskEntity!.description;
    }
    super.initState();
  }

  void onSubmit() {
    if (!formKey.currentState!.validate()) return;
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final now = DateTime.now();

    if (widget.isUpdate) {
      final updated = widget.taskEntity!.copyWith(
        title: title,
        description: description,
      );

      context.read<OperationsTaskBloc>().add(
        UpdateTasksEvent(taskEntity: updated),
      );
    } else {
      final task = TaskEntity(
        title: title,
        description: description,
        createdAt: now,
        isDone: false,
      );
      context.read<OperationsTaskBloc>().add(AddTasksEvent(taskEntity: task));
    }
  }

  void onTaskDone() {
    final task = widget.taskEntity!.toggleDone();
    final state = widget.taskEntity!.isDone
        ? "the task is undone"
        : "the task is done";
    context.read<OperationsTaskBloc>().add(
      DoneTaskEvent(taskEntity: task, refreshState: state),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.isUpdate ? "Update Task" : "Create New Task",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue.shade300,
                ),
              ),
              SizedBox(height: 30),
              buildTextField(
                controller: titleController,
                label: "Title",
                icon: Icons.title,
                validatorText: "Please enter the task title",
                maxLines: 1,
                maxLength: 20,
              ),
              SizedBox(height: 20),
              buildTextField(
                controller: descriptionController,
                label: "Description",
                icon: Icons.description,
                validatorText: "Please enter the task description",
                maxLines: 5,
                maxLength: 150,
              ),
              SizedBox(height: 50),
              buildBtn(onSubmit, widget.isUpdate ? "Update Task" : "Add Task"),
              if (widget.isUpdate)
                buildBtn(
                  onTaskDone,
                  widget.taskEntity!.isDone
                      ? "restart the task"
                      : "complete the task",
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String validatorText,
    required int maxLines,
    required int maxLength,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: (v) {
        if (v == null || v.isEmpty) {
          return validatorText;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.lightBlue.shade300),
        filled: true,
        fillColor: Colors.white.withOpacity(0.15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.lightBlue.shade300, width: 2),
        ),
      ),
    );
  }

  Widget buildBtn(Function onSubmit, String textBtn) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: () => onSubmit(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.lightBlue.shade300,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
        ),
        child: Text(
          textBtn,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
