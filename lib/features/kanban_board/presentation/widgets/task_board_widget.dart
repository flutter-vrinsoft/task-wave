import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boardview/board_item.dart' show BoardItem, BoardItemState;
import 'package:flutter_boardview/board_list.dart' show BoardList;
import 'package:flutter_boardview/boardview.dart' show BoardView;
import 'package:flutter_boardview/boardview_controller.dart' show BoardViewController;
import 'package:size_config/size_config.dart';
import 'package:task_wave/core/theme/app_sizes.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_bloc.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_event.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_state.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/task_detail_page.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/board/board.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/task_tile.dart';

class TaskBoardWidget extends StatefulWidget {
  TaskBoardWidget({super.key});

  @override
  State<TaskBoardWidget> createState() => _TaskBoardWidgetState();
}

class _TaskBoardWidgetState extends State<TaskBoardWidget> {
  final BoardViewController boardViewController = new BoardViewController();

  List<BoardListObject> _listData = [];

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

          List<Task>? todoTasks = [];
          List<Task>? pendingTasks = [];
          List<Task>? completedTasks = [];

          todoTasks = tasks.where((element) => element.status == "todo").toList();
          pendingTasks = tasks.where((element) => element.status == "pending").toList();
          completedTasks = tasks.where((element) => element.status == "completed").toList();

          List<BoardList> _lists = [];

          _listData = [
            BoardListObject(title: "To-Do", items: todoTasks),
            BoardListObject(title: "In Process", items: pendingTasks),
            BoardListObject(title: "Completed", items: completedTasks),
          ];

          for (int i = 0; i < _listData.length; i++) {
            _lists.add(_createBoardList(_listData[i]));
          }

          return Builder(builder: (context) {
            return Container(
              height: 650.h,
              child: BoardView(
                lists: _lists,
                boardViewController: boardViewController,
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

  BoardItem buildBoardItem(Task model) {
    return BoardItem(
        onStartDragItem: (int? listIndex, int? itemIndex, BoardItemState state) {
          debugPrint("ON START DROPPED listIndex $listIndex");
        },
        onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex, int? oldItemIndex, BoardItemState state) {
          //Used to update our local item data
          if (oldListIndex != listIndex) {
            debugPrint("ITEM DROPPED listIndex $listIndex");
            debugPrint("ITEM DROPPED itemIndex $itemIndex");
            debugPrint("ITEM DROPPED oldListIndex $oldListIndex");
            debugPrint("ITEM DROPPED oldListIndex $oldListIndex");

            if (listIndex == 0) {
              context.read<TaskBloc>().add(UpdateTaskEvent(model.copyWith(status: 'todo', isCompleted: false)));
            }
            if (listIndex == 1) {
              context.read<TaskBloc>().add(UpdateTaskEvent(model.copyWith(status: 'pending', isCompleted: false)));
            }
            if (listIndex == 2) {
              context.read<TaskBloc>().add(UpdateTaskEvent(model.copyWith(status: 'completed', isCompleted: true)));
            }
          }

          var item = _listData[oldListIndex!].items[oldItemIndex!];

          _listData[oldListIndex].items.removeAt(oldItemIndex);

          _listData[listIndex!].items.insert(itemIndex!, item);
        },
        onDragItem: (int oldListIndex, int oldItemIndex, int newListIndex, int newItemIndex, BoardItemState state) {
          debugPrint("ON DRAG ITEM ${oldListIndex}");
          debugPrint("ON DRAG ITEM ${oldItemIndex}");
          debugPrint("ON DRAG ITEM ${newListIndex}");
          debugPrint("ON DRAG ITEM ${state}");
        },
        onTapItem: (int? listIndex, int? itemIndex, BoardItemState state) async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskDetailPage(task: model)),
          );
        },
        item: Container(
          margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: TaskTile(model: model),
        ));
  }

  BoardList _createBoardList(BoardListObject list) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.items.length; i++) {
      items.insert(i, buildBoardItem(list.items[i]));
    }

    return BoardList(
      onStartDragList: (int? listIndex) {},
      onTapList: (int? listIndex) async {},
      onDropList: (int? listIndex, int? oldListIndex) {
        //Update our local list data
        var list = _listData[oldListIndex!];
        _listData.removeAt(oldListIndex);
        _listData.insert(listIndex!, list);
      },
      headerBackgroundColor: Colors.black26,
      backgroundColor: Colors.black26,
      header: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                if (list.title.toLowerCase() == "to-do")
                  Icon(
                    Icons.padding_outlined,
                    color: Colors.white,
                  ),
                if (list.title.toLowerCase() == "in process")
                  Icon(
                    Icons.access_time_filled_sharp,
                    color: Colors.white,
                  ),
                if (list.title.toLowerCase() == "completed")
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                context.hGap4,
                Text(
                  list.title,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
      items: items,
    );
  }
}
