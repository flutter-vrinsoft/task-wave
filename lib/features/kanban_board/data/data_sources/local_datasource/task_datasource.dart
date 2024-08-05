import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_wave/features/kanban_board/data/models/comment.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';

class TaskDataSource {
  final Box<Task> taskBox;

  TaskDataSource({required this.taskBox});

  Future<List<Task>> getTasks() async {
    return taskBox.values.toList();
  }

  Future<void> addTask(Task task) async {
    await taskBox.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    await taskBox.put(task.id, task);
  }

  Future<void> deleteTask(String taskId) async {
    await taskBox.delete(taskId);
  }

  Future<void> addCommentToTask(String taskId, Comment comment) async {
    final task = taskBox.get(taskId);
    if (task != null) {
      task.comments.add(comment);
      await taskBox.put(task.id, task);
    }
  }
}
