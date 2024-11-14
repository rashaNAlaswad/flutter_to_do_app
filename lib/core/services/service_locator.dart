import '../../features/task/cubit/task_cubit.dart';
import 'package:get_it/get_it.dart';

import '../database/sqflite/sqflite_helper.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerLazySingleton(() => SqfliteHelper());
  sl.registerLazySingleton(() => TaskCubit());
}
