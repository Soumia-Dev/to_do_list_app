import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/core/widgets.dart';
import 'package:to_do_list_app/domain/entities/task_entity.dart';
import 'package:to_do_list_app/presentations/bloc/operationsTask/operations_task_bloc.dart'
    hide UpdateTasksEvent;
import 'package:to_do_list_app/presentations/pages/addUpdate/form_task.dart';

import '../../bloc/getTask/get_task_bloc.dart';

class AddUpdateTaskWidgets {
  Widgets widgets = Widgets();

  Widget body(bool isUpdate, TaskEntity? taskEntity) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: BlocConsumer<OperationsTaskBloc, OperationsTaskState>(
        listener: (context, state) {
          if (state is SuccessfulOperation) {
            widgets.buildSnackBar(context, state.successMessage, Colors.green);
            context.read<GetTaskBloc>().add(UpdateTasksEvent());
            Navigator.of(context).pop();
          } else if (state is ErrorOperation) {
            widgets.buildSnackBar(
              context,
              state.errorMessage,
              Colors.redAccent,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingOperationState) {
            return widgets.buildLoading();
          }
          return FormTask(isUpdate: isUpdate, taskEntity: taskEntity);
        },
      ),
    );
  }
}
