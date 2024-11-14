import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/routes/app_router.dart';
import '../core/services/service_locator.dart';
import '../core/theme/app_theme.dart';
import '../features/task/cubit/task_cubit.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => BlocProvider(
        create: (context) => sl<TaskCubit>()..getTasks(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme(),
          themeMode: ThemeMode.dark,
          onGenerateRoute: appRouter.getRoute,
        ),
      ),
    );
  }
}
