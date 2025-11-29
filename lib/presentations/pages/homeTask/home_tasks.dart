import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/presentations/bloc/getTask/get_task_bloc.dart';

import '../addUpdate/add_update.dart';

class HomeTask extends StatelessWidget {
  const HomeTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<GetTaskBloc, GetTaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskLoadedState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: state.tasks.isEmpty
                  ? Center(child: Text("there is no tasks"))
                  : ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(state.tasks[index].title));
                      },
                    ),
            );
          } else if (state is TaskErrorState) {
            return Center(child: Text(state.messageError));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<GetTaskBloc>(context).add(GetTasksEvent());
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddUpdate(
              //    isUpdatePost: false,
            ),
          ),
        );
      },
      child: Icon(Icons.add),
    );
  }
}
