import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../features/task/presentation/home/screens/notification_details_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/task/presentation/addTask/add_task_screen.dart';
import '../../features/task/presentation/home/screens/task_screen.dart';
import 'routes.dart';

class AppRouter {
  Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const TaskScreen(),
        );
      case Routes.addTask:
        return MaterialPageRoute(
          builder: (_) => const AddTaskScreen(),
        );
      case Routes.notificationDetails:
        final response = settings.arguments as NotificationResponse;
        return MaterialPageRoute(
          builder: (_) => NotificationDetailsScreen(
            response: response,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Center(
            child: Scaffold(body: Text('Page not found')),
          ),
        );
    }
  }
}
