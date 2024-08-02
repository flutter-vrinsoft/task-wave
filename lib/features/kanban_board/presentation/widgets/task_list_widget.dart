import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boardview/boardview_controller.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_bloc.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_state.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/task_detail_page.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/task_tile.dart';

class TaskListWidget extends StatefulWidget {
  TaskListWidget({super.key});

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  final BoardViewController boardViewController = new BoardViewController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TaskLoaded) {
          final tasks = state.tasks;

          return Builder(builder: (context) {
            return Container(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: tasks.length,
                itemBuilder: (ctx, ind) {
                  Task model = state.tasks[ind];

                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TaskDetailPage(task: model)),
                        );
                      },
                      child: TaskTile(model: model));
                },
              ),
            );
          });
        } else if (state is TaskError) {
          return Center(child: Text('Failed to load tasks: ${state.error}'));
        }
        return Container();
      },
    );
  }
}
