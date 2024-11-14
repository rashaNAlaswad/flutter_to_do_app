import 'package:sqflite/sqflite.dart';

import '../../../features/task/model/task_model.dart';
import '../../utils/constants.dart';

class SqfliteHelper {
  late Database db;

  void init() async {
    db = await openDatabase(
      Constants.dataBaseName,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE ${Constants.tableName} (${Constants.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${Constants.title} TEXT, ${Constants.description} TEXT, ${Constants.date} TEXT, ${Constants.startTime} TEXT , ${Constants.endTime} TEXT, ${Constants.color} INTEGER, ${Constants.isCompleted} INTEGER)');
      },
    );
  }

  Future<int> insert(TaskModel task) async {
    return await db.rawInsert('''
      INSERT INTO ${Constants.tableName}( 
      ${Constants.title} ,${Constants.description},${Constants.date},${Constants.startTime},${Constants.endTime} ,${Constants.color} ,${Constants.isCompleted} )
         VALUES
         ('${task.title}','${task.description}','${task.date}','${task.startTime}','${task.endTime}','${task.color}','${task.isCompleted}')''');
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    return await db.rawQuery('SELECT * FROM ${Constants.tableName}');
  }

  Future<int> delete(int id) async {
    return await db.delete(Constants.tableName,
        where: '${Constants.id} = ?', whereArgs: [id]);
  }

  Future<int> updateTaskStatus(int id, int status) async {
    return await db.rawUpdate(
        'UPDATE ${Constants.tableName} SET ${Constants.isCompleted} = ? WHERE ${Constants.id} = ?',
        [status, id]);
  }
}
