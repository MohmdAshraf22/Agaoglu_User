import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/core/utils/color_manager.dart';
import 'package:tasks/modules/task/data/data_source/remote_data_source.dart';
import 'package:tasks/modules/task/data/repository/task_repo.dart';
import 'package:tasks/modules/task/presentation/cubit/task_cubit.dart';
import 'package:tasks/modules/task/presentation/screen/tasks_screen.dart'; // Correct import

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: MaterialApp(
        title: 'Task Management App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: AppBarTheme(surfaceTintColor: ColorManager.white),
        ),
        home: TaskListScreen(),
      ),
    );
  }
}
