import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks/core/local/shared_prefrences.dart';
import 'package:tasks/core/utils/color_manager.dart';
import 'package:tasks/core/utils/localization_manager.dart';
import 'package:tasks/generated/l10n.dart';
import 'package:tasks/modules/task/presentation/cubit/task_cubit.dart';
import 'package:tasks/modules/task/presentation/screen/tasks_screen.dart'; // Correct import
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  await LocalizationManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocProvider(
        create: (context) => TaskCubit(),
        child: MaterialApp(
          title: 'Task Management App',
          locale: LocalizationManager.getCurrentLocale(),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            appBarTheme: AppBarTheme(surfaceTintColor: ColorManager.white),
          ),
          home: TaskListScreen(),
        ),
      );
    });
  }
}
