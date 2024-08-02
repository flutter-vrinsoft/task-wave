import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:size_config/size_config.dart';
import 'package:task_wave/core/routes/app_routes.dart';
import 'package:task_wave/core/theme/app_sizes.dart';
import 'package:task_wave/core/theme/app_theme.dart';
import 'package:task_wave/core/util/constants/app_strings.dart';
import 'package:task_wave/core/util/enums.dart';
import 'package:task_wave/core/util/helper_functions/extension_functions.dart';
import 'package:task_wave/core/util/helper_functions/helper_functions.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/base_widget.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/task_board_widget.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/task_list_widget.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool isViewAsBoard = true;
  ViewAs calendarView = ViewAs.list;

  @override
  void initState() {
    super.initState();
  }

  buildBody() {
    return Container(
      padding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 10),
      child: Column(
        children: [
          appBar(),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                isViewAsBoard = !isViewAsBoard;
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: SegmentedButton<ViewAs>(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (states) {
                        if (states.contains(WidgetState.selected)) {
                          return context.primary;
                        }
                        return null;
                      },
                    ),
                  ),
                  segments: const <ButtonSegment<ViewAs>>[
                    ButtonSegment<ViewAs>(
                      value: ViewAs.list,
                      label: Text('List'),
                      icon: Icon(Icons.list),
                    ),
                    ButtonSegment<ViewAs>(
                        value: ViewAs.board, label: Text('Board'), icon: Icon(Icons.view_kanban_outlined)),
                  ],
                  selected: <ViewAs>{calendarView},
                  onSelectionChanged: (newSelection) {
                    setState(() {
                      calendarView = newSelection.first;
                      isViewAsBoard = calendarView == ViewAs.list;
                    });
                  },
                ),
              ),
            ),
          ),
          if (isViewAsBoard) Expanded(child: TaskListWidget()) else Expanded(child: TaskBoardWidget()),
        ],
      ),
    );
  }

  appBar() {
    return Container(
      width: AppSizes.screenWidth,
      margin: EdgeInsets.only(top: kToolbarHeight),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: context.onInverseSurface,
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
        title: AppStrings.taskList.toTextWidget(
          style: TextStyle(color: context.surface, fontWeight: FontWeight.w400, fontSize: 26.sp),
        ),
        contentPadding: EdgeInsets.zero,
        trailing: GestureDetector(
          onTap: () {
            pushPage(context, AppRoutes.createTaskRoute);
          },
          child: Icon(
            Icons.add_circle,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidget(widget: buildBody()),
    );
  }
}
