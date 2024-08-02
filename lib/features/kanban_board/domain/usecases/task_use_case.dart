import 'package:task_wave/features/kanban_board/data/models/comment.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/domain/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;
  GetTasks(this.repository);
  Future<List<Task>> call() {
    return repository.getTasks();
  }
}

class AddTask {
  final TaskRepository repository;
  AddTask(this.repository);
  Future<void> call(Task task) {
    return repository.addTask(task);
  }
}

class UpdateTask {
  final TaskRepository repository;
  UpdateTask(this.repository);
  Future<void> call(Task task) {
    return repository.updateTask(task);
  }
}

class DeleteTask {
  final TaskRepository repository;
  DeleteTask(this.repository);
  Future<void> call(String taskId) {
    return repository.deleteTask(taskId);
  }
}

class AddCommentToTask {
  final TaskRepository repository;

  AddCommentToTask(this.repository);

  Future<void> call(String taskId, Comment comment) {
    return repository.addCommentToTask(taskId, comment);
  }
}
