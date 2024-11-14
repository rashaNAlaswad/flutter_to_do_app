import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_to_do_app/core/utils/app_strings.dart';
import '../../features/task/model/task_model.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();
  static onTap(NotificationResponse notificationResponse) {
    log('Notification id: ${notificationResponse.id!.toString()}');
    log(notificationResponse.payload!.toString());
    streamController.add(notificationResponse);
  }

  static Future initialize() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  //showSchduledNotification
  static void showScheduledNotification(
      {required DateTime curretDate,
      required TimeOfDay scheduleDateTime,
      required TaskModel task}) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      AppStrings.scheduledChannelId,
      AppStrings.scheduledChannelName,
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = const NotificationDetails(
      android: android,
    );
    tz.initializeTimeZones();
    log(tz.local.name);
    log("Before ${tz.TZDateTime.now(tz.local).hour}");
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    log(currentTimeZone);
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    log(tz.local.name);
    log("After ${tz.TZDateTime.now(tz.local).hour}");

    final String taskPayload = jsonEncode(task.toJson());

    // from String to integer
    final int channelId = int.parse(AppStrings.scheduledChannelId);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      channelId,
      task.title,
      task.description,
      tz.TZDateTime(
        tz.local,
        curretDate.year,
        curretDate.month,
        curretDate.day,
        scheduleDateTime.hour,
        scheduleDateTime.minute,
      ).subtract(const Duration(minutes: 5)),
      details,
      payload: taskPayload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  //showDailySchduledNotification
  static void showDailySchduledNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      AppStrings.dailyChannelId,
      AppStrings.dailyChannelName,
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = const NotificationDetails(
      android: android,
    );
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTime = tz.TZDateTime.now(tz.local);
    log("currentTime.day:${currentTime.day}");
    log("currentTime.hour:${currentTime.hour}");

    var scheduleTime = tz.TZDateTime(
        tz.local, currentTime.year, currentTime.month, currentTime.day, 22);
    log("scheduledTime.day:${scheduleTime.day}");
    log("scheduledTime.hour:${scheduleTime.hour}");

    if (scheduleTime.isBefore(currentTime)) {
      scheduleTime = scheduleTime.add(const Duration(days: 1));
      log("AfterAddedscheduledTime.day:${scheduleTime.day}");
      log("AfterAddedscheduledTime.hour:${scheduleTime.hour}");
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      3,
      AppStrings.dailyNotificationTitle,
      AppStrings.dailyNotificationBody,
      scheduleTime,
      details,
      payload: 'dailySchduledNotification',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
