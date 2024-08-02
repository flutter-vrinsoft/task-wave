import 'package:equatable/equatable.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskError extends TaskState {
  final String error;

  const TaskError(this.error);

  @override
  List<Object> get props => [error];
}
