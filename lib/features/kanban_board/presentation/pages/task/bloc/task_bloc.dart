import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_wave/core/util/helper_functions/helper_functions.dart';
import 'package:task_wave/core/util/services/notification_service.dart';
import 'package:task_wave/features/kanban_board/domain/usecases/task_use_case.dart';

import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;
  final AddCommentToTask addCommentToTask;

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
    required this.addCommentToTask,
  }) : super(TaskLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<AddCommentToTaskEvent>(_onAddCommentToTask);
  }

  void _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    try {
      final tasks = await getTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  void _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await addTask(event.task);
      final updatedTasks = await getTasks();
      emit(TaskLoaded(updatedTasks));
      if (event.isAddToCalendar) {
        addToCalendar(event.task);
      }
      NotificationService().scheduleNotification(event.task);
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await updateTask(event.task);
      final updatedTasks = await getTasks();
      emit(TaskLoaded(updatedTasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await deleteTask(event.taskId);
      final updatedTasks = await getTasks();
      emit(TaskLoaded(updatedTasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  void _onAddCommentToTask(AddCommentToTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await addCommentToTask(event.taskId, event.comment);
      final updatedTasks = await getTasks();
      emit(TaskLoaded(updatedTasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
