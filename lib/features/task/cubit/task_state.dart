import '../model/task_model.dart';

sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class ReadTaskLoadingState extends TaskState {}

final class ReadTaskSucessState extends TaskState {
  final List<TaskModel> tasks;
  ReadTaskSucessState(this.tasks);
}

final class ReadTaskErrorState extends TaskState {
  final String message;
  ReadTaskErrorState(this.message);
}

// Delete task
final class DeleteTaskLoadingState extends TaskState {}

final class DeleteTaskSucessState extends TaskState {}

final class DeleteTaskErrorState extends TaskState {
  final String message;
  DeleteTaskErrorState(this.message);
}

// Update Status Task
final class UpdateTaskLoadingState extends TaskState {}

final class UpdateTaskSucessState extends TaskState {}

final class UpdateTaskErrorState extends TaskState {
  final String message;
  UpdateTaskErrorState(this.message);
}

// pick date from add task calender
final class ChangeDateLoadingState extends TaskState {}
final class ChangeDateSucessState extends TaskState {}

// select date from home calender
final class SelectDateState extends TaskState {}

// Add Task
final class AddTaskLoadingState extends TaskState {}
final class AddTaskSucessState extends TaskState {}
final class AddTaskErrorState extends TaskState {
  final String message;
  AddTaskErrorState(this.message);
}

// Change Color
final class ChangeColorSucessState extends TaskState {}

// set start time
final class SetStartTimeSucessState extends TaskState {}

// set end time
final class SetEndTimeSucessState extends TaskState {}
