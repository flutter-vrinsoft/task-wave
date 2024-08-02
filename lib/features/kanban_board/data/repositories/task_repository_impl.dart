import 'package:task_wave/features/kanban_board/data/data_sources/local_datasource/task_datasource.dart';
import 'package:task_wave/features/kanban_board/data/models/comment.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource dataSource;

  TaskRepositoryImpl({required this.dataSource});

  @override
  Future<List<Task>> getTasks() async {
    return dataSource.getTasks();
  }

  @override
  Future<void> addTask(Task task) async {
    await dataSource.addTask(task);
  }

  @override
  Future<void> updateTask(Task task) async {
    await dataSource.updateTask(task);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await dataSource.deleteTask(taskId);
  }

  @override
  Future<void> addCommentToTask(String taskId, Comment comment) async {
    await dataSource.addCommentToTask(taskId, comment);
  }

  @override
  Future<void> addTaskGoogleCalendar(Task task) async {

    await dataSource.addTask(task);
  }
}
