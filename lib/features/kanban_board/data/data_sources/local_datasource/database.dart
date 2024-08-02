import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';

class ToDoDataBase {
  late final box;
  ToDoDataBase._create(this.box) {}

  static Future<ToDoDataBase> initialize() async {
    final box = Hive.box<Task>('tasks');
    return ToDoDataBase._create(box);
  }
}
