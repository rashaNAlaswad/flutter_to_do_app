import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/database/sqflite/sqflite_helper.dart';
import '../../../core/services/local_notification.dart';
import '../../../core/services/service_locator.dart';
import '../model/task_model.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  bool isBottomSheetOpen = false;
  bool isPermissionGranted = false;

  List<TaskModel> _tasks = [];

  // Get Tasks
  getTasks() async {
    emit(ReadTaskLoadingState());
    try {
      await sl<SqfliteHelper>().getTasks().then((value) {
        _tasks = value
            .map((e) => TaskModel.fromJson(e))
            .toList()
            .where(
              (element) =>
                  element.date == DateFormat.yMd().format(selectedDate),
            )
            .toList();
        emit(ReadTaskSucessState(_tasks));
      });
    } catch (e) {
      emit(ReadTaskErrorState(e.toString()));
    }
  }

// Delete Task
  deleteTask(int id) async {
    emit(DeleteTaskLoadingState());
    try {
      await sl<SqfliteHelper>().delete(id);
      getTasks();
      emit(DeleteTaskSucessState());
    } catch (e) {
      emit(DeleteTaskErrorState(e.toString()));
    }
  }

// Update Task Status
  updateTaskStatus(int id) async {
    emit(UpdateTaskLoadingState());
    try {
      int taskIndex = _tasks.indexWhere((task) => task.id == id);
      int status = _tasks[taskIndex].isCompleted == 0 ? 1 : 0;
      await sl<SqfliteHelper>().updateTaskStatus(id, status);
      getTasks();
      emit(UpdateTaskSucessState());
    } catch (e) {
      emit(UpdateTaskErrorState(e.toString()));
    }
  }

  DateTime selectedDate = DateTime.now();
  void getSelectedDate(DateTime date) {
    emit(ChangeDateLoadingState());
    selectedDate = date;
    emit(SelectDateState());
    getTasks();
  }

  //Add New Task
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  // get date
  DateTime currentDate = DateTime.now();
  void setDate(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: currentDate,
        lastDate: DateTime.now().add(const Duration(days: 365)));

    if (datePicker != null) {
      currentDate = datePicker;
      emit(ChangeDateSucessState());
    }
  }

  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(hours: 1)));
  TimeOfDay? scheduleTime;

  void setStartTime(context) async {
    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedStartTime != null) {
      startTime = pickedStartTime.format(context);
      scheduleTime = pickedStartTime;
      emit(SetStartTimeSucessState());
    } else {
      scheduleTime =
          TimeOfDay(hour: currentDate.hour, minute: currentDate.minute);
    }
  }

  void setEndTime(context) async {
    TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedEndTime != null) {
      endTime = pickedEndTime.format(context);
      emit(SetEndTimeSucessState());
    }
  }

// Add New Task
  void addTask() {
    emit(AddTaskLoadingState());
    try {
      var taskModel = TaskModel(
        title: titleController.text,
        description: noteController.text,
        date: DateFormat.yMd().format(currentDate),
        startTime: startTime,
        endTime: endTime,
        color: colorCode,
        isCompleted: 0,
      );
      sl<SqfliteHelper>().insert(TaskModel(
        title: titleController.text,
        description: noteController.text,
        date: DateFormat.yMd().format(currentDate),
        startTime: startTime,
        endTime: endTime,
        color: colorCode,
        isCompleted: 0,
      ));
      LocalNotification.showScheduledNotification(
        curretDate: currentDate,
        scheduleDateTime: scheduleTime!,
        task: taskModel,
      );
      emit(AddTaskSucessState());
    } catch (e) {
      emit(AddTaskErrorState(e.toString()));
    }
  }

  void clear() {
    titleController.clear();
    noteController.clear();
    colorCode = 0xFF255F85;
    currentDate = DateTime.now();
  }

  int colorCode = 0xFF255F85;
  void updatecolorCode(int color) {
    colorCode = color;
    emit(ChangeColorSucessState());
  }
}
