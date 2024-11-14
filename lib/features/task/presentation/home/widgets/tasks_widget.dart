import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/functions.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/failure_widget.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../cubit/task_cubit.dart';
import '../../../cubit/task_state.dart';
import 'no_data_widget.dart';
import 'tasks_list.dart';

class TasksWidget extends StatelessWidget {
  const TasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is DeleteTaskSucessState) {
          showSnackBar(
              context: context,
              message: AppStrings.messageDeleteTask,
              state: SnakeState.success);
        } else if (state is DeleteTaskErrorState) {
          showSnackBar(
              context: context,
              message: state.message,
              state: SnakeState.error);
        }
      },
      builder: (context, state) {
        if (state is ReadTaskSucessState) {
          if (state.tasks.isEmpty) {
            return const Align(
                alignment: Alignment.center, child: NoDataWidget());
          }
          return TaskListWidget(tasks: state.tasks);
        } else if (state is ReadTaskErrorState) {
          return FailureWidget(message: state.message);
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}
