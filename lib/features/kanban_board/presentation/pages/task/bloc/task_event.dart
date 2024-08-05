import 'package:equatable/equatable.dart';
import 'package:task_wave/features/kanban_board/data/models/comment.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

// ignore: must_be_immutable
class AddTaskEvent extends TaskEvent {
  final Task task;
  bool isAddToCalendar;

  AddTaskEvent(this.task, this.isAddToCalendar);

  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  UpdateTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  DeleteTaskEvent(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class AddCommentToTaskEvent extends TaskEvent {
  final String taskId;
  final Comment comment;

  AddCommentToTaskEvent(this.taskId, this.comment);

  @override
  List<Object> get props => [taskId, comment];
}
