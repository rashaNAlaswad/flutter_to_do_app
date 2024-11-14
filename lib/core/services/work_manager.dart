import 'local_notification.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    LocalNotification.showDailySchduledNotification();
    return Future.value(true);
  });
}

class WorkManagerService {
  Future<void> initialize() async {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

    registerTask();
  }

  void registerTask() async {
    await Workmanager().registerPeriodicTask(
      '1',
      'DailySchduledNotification',
      frequency: const Duration(days: 1),
    );
  }

  void cancleTask(String taskId) {
    Workmanager().cancelByUniqueName(taskId);
  }
}
