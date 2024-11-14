import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/notification_permission.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../cubit/task_cubit.dart';
import '../widgets/tasks_widget.dart';
import '../../../../../core/routes/extensions.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/app_colors.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NotificationPermissionHandler(),
              buildGreetingText(context),
              SizedBox(height: 20.h),
              _buildDatePicker(context),
              SizedBox(height: 20.h),
              const Expanded(child: TasksWidget()),
            ],
          ),
        ),
        floatingActionButton: context.read<TaskCubit>().isBottomSheetOpen
            ? null
            : FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => context.pushNamed(Routes.addTask).then(
                  (value) {
                    if (context.mounted) {
                      context.read<TaskCubit>().getTasks();
                    }
                  },
                ),
              ),
      ),
    );
  }

  Text buildGreetingText(BuildContext context) {
    final currentHour = DateTime.now().hour;
    final greeting =
        currentHour < 12 ? AppStrings.goodMorning : AppStrings.goodAfternoon;

    return Text(
      greeting,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  DatePicker _buildDatePicker(BuildContext context) {
    return DatePicker(
      height: 100.h,
      DateTime.now(),
      initialSelectedDate: DateTime.now(),
      selectionColor: AppColors.primary,
      selectedTextColor: AppColors.white,
      dateTextStyle: Theme.of(context).textTheme.bodyMedium!,
      dayTextStyle: Theme.of(context).textTheme.bodyMedium!,
      monthTextStyle: Theme.of(context).textTheme.bodyMedium!,
      onDateChange: (date) {
        context.read<TaskCubit>().getSelectedDate(date);
      },
    );
  }
}

