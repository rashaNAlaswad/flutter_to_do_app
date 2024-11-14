import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/helpers/functions.dart';
import '../../../../core/routes/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../cubit/task_cubit.dart';
import '../../cubit/task_state.dart';
import 'colors_widget.dart';
import 'widgets/task_component.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.addTask),
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is AddTaskSucessState) {
            context.read<TaskCubit>().clear();
            context.pop();
          } else if (state is AddTaskErrorState) {
            showSnackBar(
                context: context,
                message: state.message,
                state: SnakeState.error);
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              Form(
                key: context.read<TaskCubit>().formKey,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleTaskComponent(context),
                        SizedBox(
                          height: 24.h,
                        ),
                        _buildNoteTaskComponent(context),
                        SizedBox(
                          height: 24.h,
                        ),
                        _buildDateTaskComponent(context),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStartTimeComponent(context),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: _buildEndtTimeComponent(context),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        ColorsWidget(
                            selectedColor: context.read<TaskCubit>().colorCode),
                        SizedBox(
                          height: 60.h,
                        ),
                        state is AddTaskLoadingState
                            ? const LoadingWidget()
                            : _buildAddTaskButton(context),
                      ],
                    )),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          final formKey = context.read<TaskCubit>().formKey;
          if (formKey.currentState!.validate()) {
            context.read<TaskCubit>().addTask();
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50.h),
        ),
        child: const Text(AppStrings.addTask));
  }

  Widget _buildDateTaskComponent(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();
    return TaskComponent(
      title: AppStrings.date,
      hint: DateFormat.yMMMd().format(taskCubit.currentDate),
      readOnly: true,
      suffixIcon: IconButton(
        onPressed: () => taskCubit.setDate(context),
        icon: const Icon(
          Icons.calendar_month_rounded,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _buildNoteTaskComponent(BuildContext context) {
    return TaskComponent(
      title: AppStrings.taskDescription,
      hint: AppStrings.taskDescriptionHint,
      controller: context.read<TaskCubit>().noteController,
      validator: (value) => validateString(
        value,
        AppStrings.taskDescriptionHint,
      ),
    );
  }

  Widget _buildTitleTaskComponent(BuildContext context) {
    return TaskComponent(
      title: AppStrings.taskName,
      hint: AppStrings.taskHint,
      controller: context.read<TaskCubit>().titleController,
      validator: (value) => validateString(
        value,
        AppStrings.taskDescriptionHint,
      ),
    );
  }

  Widget _buildStartTimeComponent(BuildContext context) {
    return TaskComponent(
      title: AppStrings.startTime,
      hint: context.read<TaskCubit>().startTime,
      readOnly: true,
      suffixIcon: IconButton(
        icon: const Icon(
          Icons.timer_outlined,
          color: AppColors.white,
        ),
        onPressed: () => context.read<TaskCubit>().setStartTime(context),
      ),
    );
  }

  Widget _buildEndtTimeComponent(BuildContext context) {
    return TaskComponent(
      title: AppStrings.endTime,
      hint: context.read<TaskCubit>().endTime,
      readOnly: true,
      suffixIcon: IconButton(
        onPressed: () => context.read<TaskCubit>().setEndTime(context),
        icon: const Icon(
          Icons.timer_outlined,
          color: AppColors.white,
        ),
      ),
    );
  }
}
