import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasks/core/local/shared_prefrences.dart';
import 'package:tasks/core/utils/localization_manager.dart';
import 'package:tasks/firebase_options.dart';
import 'package:tasks/modules/task/ui/screen/tasks_screen.dart';
import 'package:tasks/modules/user/ui/screen/login_screen.dart';

class AppInitializer {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAppCheck.instance.activate(androidProvider: AndroidProvider.debug);
    FirebaseAppCheck.instance.getToken();
    await CacheHelper.init();
    await LocalizationManager.init();
  }

  static Widget getFirstScreen(){
    return FirebaseAuth.instance.currentUser == null
        ? LoginScreen()
        : TaskListScreen();
  }
}
