import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_to_do_app/core/utils/app_strings.dart';
import '../../../../../core/routes/extensions.dart';
import '../../../../../core/routes/routes.dart';

import '../../../../../core/helpers/functions.dart';
import '../../../../../core/services/local_notification.dart';
import '../../../cubit/task_cubit.dart';

class NotificationPermissionHandler extends StatefulWidget {
  const NotificationPermissionHandler({super.key});

  @override
  NotificationPermissionHandlerState createState() =>
      NotificationPermissionHandlerState();
}

class NotificationPermissionHandlerState
    extends State<NotificationPermissionHandler> {
  @override
  void initState() {
    super.initState();
    final taskCubit = context.read<TaskCubit>();

    if (!taskCubit.isPermissionGranted) {
      _requestNotificationPermission();
    }
    _listenToNotificationStream();
  }

  Future<void> _requestNotificationPermission() async {
    final bool? granted = await LocalNotification
        .flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    if (granted == true) {
      log("Notification permission granted");
      if (mounted) {
        context.read<TaskCubit>().isPermissionGranted = true;
      }
    } else {
      log("Notification permission denied");
      if (mounted) {
        showPermissionDialog(context);
      }
    }
  }

  void _listenToNotificationStream() {
    LocalNotification.streamController.stream.listen(
      (notificationResponse) {
        log('Notification id: ${notificationResponse.id!.toString()}');
        log("Notification Payload: ${notificationResponse.payload}");
        if(notificationResponse.id == int.parse(AppStrings.scheduledChannelId)){
           context.pushNamed(Routes.notificationDetails,
            arguments: notificationResponse);
        } else{
          context.pushNamed(Routes.addTask);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
