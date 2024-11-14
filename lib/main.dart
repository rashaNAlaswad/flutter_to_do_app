import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'core/bloc/bloc_observer.dart';
import 'core/database/sqflite/sqflite_helper.dart';
import 'core/routes/app_router.dart';
import 'core/services/local_notification.dart';
import 'core/services/service_locator.dart';
import 'core/services/work_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Future.wait([
    LocalNotification.initialize(),
    WorkManagerService().initialize(),
  ]);

  Bloc.observer = MyBlocObserver();
  setup();
  sl<SqfliteHelper>().init();

  runApp(
    MainApp(
      appRouter: AppRouter(),
    ),
  );
}
