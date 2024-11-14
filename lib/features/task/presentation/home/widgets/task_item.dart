import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../cubit/task_cubit.dart';
import '../../../../../core/routes/extensions.dart';
import '../../../model/task_model.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            sheetAnimationStyle: AnimationStyle(
                curve: Curves.easeInOut,
                reverseCurve: Curves.easeIn,
                duration: const Duration(milliseconds: 500)),
            context: context,
            builder: (_) => _buildBottomSheet(context)).whenComplete(() {
          context.read<TaskCubit>().isBottomSheetOpen = false;
        });
      },
      child: Container(
        decoration: _buildDecoration(),
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title,
                      style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(task.description,
                      style: Theme.of(context).textTheme.bodyMedium),
                  _buildTimeInfo(context),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              color: AppColors.white,
              width: 1.w,
              height: 70.h,
              margin: EdgeInsets.only(right: 10.w),
            ),
            _buildStatusLabel(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      width: double.infinity,
      height: 160.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.teal,
              minimumSize: Size(double.infinity, 50.h),
            ),
            onPressed: () {
              context.read<TaskCubit>().updateTaskStatus(task.id!);
              context.pop();
            },
            child: Text(
              task.isCompleted == 1
                  ? AppStrings.taskToDo
                  : AppStrings.taskCompleted,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              minimumSize: Size(double.infinity, 50.h),
            ),
            onPressed: () {
              context.read<TaskCubit>().deleteTask(task.id!);
              context.pop();
            },
            child: const Text(AppStrings.deleteTask),
          ),
        ],
      ),
    );
  }

  RotatedBox _buildStatusLabel(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Text(
        task.isCompleted == 1 ? AppStrings.completed : AppStrings.toDo,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildTimeInfo(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.timer_outlined,
        color: AppColors.red,
        size: 20,
      ),
      horizontalTitleGap: 3,
      contentPadding: EdgeInsets.zero,
      title: Text(
        '${task.startTime} - ${task.endTime}',
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppColors.red),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
        border: Border(left: BorderSide(width: 20.w, color: Color(task.color))),
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.lightBlack,
        boxShadow: const [
          BoxShadow(
            color: AppColors.lightBlack,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ]);
  }
}
