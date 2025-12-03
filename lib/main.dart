import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list_app/presentations/bloc/getTask/get_task_bloc.dart';
import 'package:to_do_list_app/presentations/bloc/operationsTask/operations_task_bloc.dart';
import 'package:to_do_list_app/presentations/bloc/selectionTask/selection_task_bloc.dart';
import 'package:to_do_list_app/presentations/pages/homeTask/home_tasks.dart';

import 'core/dependency_injection.dart' as di;
import 'data/models/task_model.dart';

Future<void> main() async {
  //hive init
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  //DI init
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<GetTaskBloc>()..add(GetTasksEvent()),
        ),
        BlocProvider(create: (context) => di.sl<OperationsTaskBloc>()),
        BlocProvider(create: (context) => SelectionTaskBloc()),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeTasks()),
    );
  }
}
