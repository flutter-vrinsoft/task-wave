import 'package:task_wave/features/kanban_board/data/models/comment.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/data/models/time_log.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String taskId);
  Future<void> addCommentToTask(String taskId, Comment comment);
  Future<void> addTimeLogToTask(String taskId, TimeLog timeLog);
  Future<void> addTaskGoogleCalendar(Task task);
}
