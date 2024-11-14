import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_to_do_app/core/utils/app_strings.dart';
import 'package:flutter_to_do_app/features/task/model/task_model.dart';

class NotificationDetailsScreen extends StatelessWidget {
  const NotificationDetailsScreen({super.key, required this.response});

  final NotificationResponse response;
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = jsonDecode(response.payload!);
    TaskModel task = TaskModel.fromJson(data);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Details'),
      ),
      body: Container(
        margin: const EdgeInsets.all(24.0),
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Color(task.color),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                task.date,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 20.h),
              Text(
                '${AppStrings.toDo} : ',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 20.h),
              Text(
                task.title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 20.h),
              Text(
                task.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 20.h),
              Text(
                '${task.startTime} - ${task.endTime}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
