import '../../../core/utils/constants.dart';

class TaskModel {
  final int? id;
  final String title;
  final String description;
  final String date;
  final String startTime;
  final String endTime;
  final int color;
  final int isCompleted;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskModel(
        id: jsonData[Constants.id],
        title: jsonData[Constants.title],
        description: jsonData[Constants.description],
        date: jsonData[Constants.date],
        startTime: jsonData[Constants.startTime],
        endTime: jsonData[Constants.endTime],
        color: jsonData[Constants.color],
        isCompleted: jsonData[Constants.isCompleted]);
  }

// Task to String
  Map<String, dynamic> toJson() => {
        Constants.id: id,
        Constants.title: title,
        Constants.description: description,
        Constants.date: date,
        Constants.startTime: startTime,
        Constants.endTime: endTime,
        Constants.color: color,
        Constants.isCompleted: isCompleted,
      };
}
