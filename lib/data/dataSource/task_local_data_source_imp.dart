import 'package:hive/hive.dart';
import 'package:to_do_list_app/data/dataSource/task_local_data_source.dart';

import '../models/task_model.dart';

class TaskLocalDataSourceImp implements TaskLocalDataSource {
  final Box<TaskModel> box;
  TaskLocalDataSourceImp({required this.box});

  @override
  Future<List<TaskModel>> getTasks() async {
    return box.keys.map((key) {
      final TaskModel model = box.get(key)!;
      return model.changeId(key);
    }).toList();
  }

  @override
  Future<void> addTask(TaskModel model) async {
    await box.add(model);
  }

  @override
  Future<void> updateTask(TaskModel model) async {
    await box.put(model.hiveId, model);
  }

  @override
  Future<void> deleteTask(Set<int> ids) async {
    await box.deleteAll(ids);
  }
}
