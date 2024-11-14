import 'package:flutter/material.dart';

import '../../../model/task_model.dart';
import 'task_item.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
  });

  final List<TaskModel> tasks ;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskItem(task: tasks[index]);
      },
    );
  }
}
