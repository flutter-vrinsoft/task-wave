import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:size_config/size_config.dart';
import 'package:task_wave/core/theme/app_sizes.dart';
import 'package:task_wave/core/theme/app_theme.dart';
import 'package:task_wave/core/util/constants/app_strings.dart';
import 'package:task_wave/core/util/helper_functions/extension_functions.dart';
import 'package:task_wave/features/kanban_board/data/models/comment.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_bloc.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/base_widget.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/custom_button.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/custom_text_field.dart';

import 'bloc/task_event.dart';

class TaskDetailPage extends StatefulWidget {
  final Task task;

  TaskDetailPage({required this.task});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  Timer? _timer;
  int _elapsedTime = 0;
  int _startTime = 0;
  bool _isRunning = false;
  List<Comment> comments = [];
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    comments = widget.task.comments;
    _elapsedTime = widget.task.spentTime;
    super.initState();
  }

  void _startTimer() {
    if (!_isRunning) {
      _startTime = DateTime.now().millisecondsSinceEpoch ~/ 1000 - _elapsedTime;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedTime = DateTime.now().millisecondsSinceEpoch ~/ 1000 - _startTime;
        });
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _elapsedTime = 0;
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
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
      ),
    );
  }

  Widget buildBody() {
    return Container(
      padding: EdgeInsets.only(left: 14.w, right: 14.w),
      child: Column(
        children: [
          appBar(),
          context.vGap16,
          Card(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: EdgeInsets.only(
                left: 14.w,
                right: 14.w,
                top: 18.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.circle,
                        color: widget.task.status.statusColorCard(),
                      ),
                      context.hGap4,
                      Flexible(
                        child: '${widget.task.name}'.toTextWidget(
                          style: TextStyle(fontSize: 28.sp, color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  context.vGap4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.description_rounded,
                        color: Colors.white,
                      ),
                      context.hGap4,
                      Flexible(
                        child: '${widget.task.description}'.toTextWidget(
                          style: TextStyle(fontSize: 22.sp, color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  context.vGap4,
                  if (widget.task.isCompleted && widget.task.status == "completed")
                    "${AppStrings.spentTime} ${widget.task.spentTime.formatDuration()}".toTextWidget(
                      style: TextStyle(fontSize: 21.sp, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  context.vGap12,
                ],
              ),
            ),
          ),
          context.vGap4,
          Row(
            children: [
              Expanded(child: dateWidget()),
              if (widget.task.status != AppStrings.statusCompleted) timeWidget(),
            ],
          ),
          context.vGap4,
          timeLogCard(),
          commentCard()
        ],
      ),
    );
  }

  Widget dateWidget() {
    return Card(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        height: 160.h,
        padding: EdgeInsets.only(
          left: 14.w,
          right: 14.w,
          top: 18.h,
          bottom: 18.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    context.hGap4,
                    AppStrings.startDate.toTextWidget(
                      style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                context.hGap4,
                '${widget.task.createdAt.toLocalDateString()}'.toTextWidget(
                  style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            context.vGap10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    context.hGap4,
                    AppStrings.goalDate.toTextWidget(
                      style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                '${widget.task.dueDate.toLocalDateString()}'.toTextWidget(
                  style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget timeWidget() {
    return Card(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
          height: 160.h,
          padding: EdgeInsets.only(
            left: 14.w,
            right: 14.w,
            top: 12.h,
            bottom: 12.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80.h,
                width: 80.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(170), border: Border.all(color: context.primary, width: 5)),
                child: Center(
                  child: _formatTime(_elapsedTime).toTextWidget(
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              context.vGap8,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (_isRunning) {
                        _stopTimer();
                      } else {
                        _startTimer();
                      }
                    },
                    icon: CircleAvatar(
                      backgroundColor: _isRunning
                          ? Colors.red
                          : _elapsedTime == 0
                              ? context.primary
                              : Colors.orangeAccent,
                      child: Icon(
                        _isRunning ? Icons.stop_circle : Icons.play_circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  context.hGap8,
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _resetTimer();
                      },
                      icon: CircleAvatar(
                        backgroundColor: context.primary,
                        child: Icon(
                          Icons.refresh_outlined,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ],
          )),
    );
  }

  Widget timeLogCard() {
    return Visibility(
      visible: widget.task.timeLogs.isNotEmpty,
      child: Card(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStrings.timeLogs.toTextWidget(
                  style: context.titleMedium
                      .copyWith(fontSize: 22.sp, color: Colors.white, fontWeight: FontWeight.w700)),
              context.vGap6,
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: comments.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, ind) {
                  return ListTile(
                    leading: Icon(Icons.comment, color: Colors.white),
                    title: comments.elementAt(ind).content.toTextWidget(
                        style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w700)),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget commentCard() {
    return Card(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: widget.task.comments.isEmpty
            ? GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomTextField(controller: commentController, title: 'Add Comment'),
                                ElevatedButton(
                                  onPressed: () {
                                    if (commentController.text != '') {
                                      setState(() {});
                                      context.read<TaskBloc>().add(AddCommentToTaskEvent(
                                          widget.task.id,
                                          Comment(
                                              userId: AppStrings.userId,
                                              taskId: widget.task.id,
                                              content: commentController.text)));
                                      commentController.clear();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: AppStrings.addComment.toTextWidget(),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppStrings.addComment.toTextWidget(
                        style: context.titleMedium
                            .copyWith(fontSize: 22.sp, color: Colors.white, fontWeight: FontWeight.w700)),
                    Icon(
                      Icons.add_circle,
                      size: 24,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppStrings.comments.toTextWidget(
                          style: context.titleMedium
                              .copyWith(fontSize: 22.sp, color: Colors.white, fontWeight: FontWeight.w700)),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomTextField(controller: commentController, title: 'Add Comment'),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {});

                                            context.read<TaskBloc>().add(AddCommentToTaskEvent(
                                                widget.task.id,
                                                Comment(
                                                    userId: AppStrings.userId,
                                                    taskId: widget.task.id,
                                                    content: commentController.text)));
                                            commentController.clear();
                                            Navigator.pop(context);
                                          },
                                          child: AppStrings.addComment.toTextWidget(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Icon(
                          Icons.add_circle,
                          size: 24,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: comments.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, ind) {
                      return ListTile(
                        leading: Icon(Icons.comment, color: Colors.white),
                        title: comments.elementAt(ind).content.toTextWidget(
                            style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w700)),
                      );
                    },
                  )
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widget.task.status != "completed"
          ? Padding(
              padding: EdgeInsets.only(bottom: 28.h, left: 14.w, right: 14.w),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                        text: AppStrings.completeTask,
                        onPressed: () {
                          updateTask(context, widget.task, "completed");
                        },
                        height: 44.h,
                        backGroundColor: context.primary,
                        fontWeight: FontWeight.w500,
                        borderColor: context.primary,
                        fontColor: Colors.white,
                        isEnabled: true,
                        borderRadius: 8,
                        textSize: 14.sp),
                  ),
                  context.hGap12,
                  Expanded(
                    child: CustomButton(
                        text: "Save Task",
                        height: 44.h,
                        onPressed: () {
                          updateTask(context, widget.task, "pending");
                        },
                        backGroundColor: Colors.orangeAccent,
                        fontWeight: FontWeight.w500,
                        borderColor: Colors.orangeAccent,
                        fontColor: Colors.white,
                        isEnabled: true,
                        borderRadius: 8,
                        textSize: 14.sp),
                  ),
                ],
              ),
            )
          : null,
      body: BaseWidget(
        widget: SingleChildScrollView(child: buildBody()),
      ),
    );
  }

  void updateTask(BuildContext context, Task task, status) {
    _stopTimer();
    final updatedTask = task.copyWith(isCompleted: status == "completed", spentHours: _elapsedTime, status: status);

    final taskBloc = BlocProvider.of<TaskBloc>(context);
    taskBloc.add(UpdateTaskEvent(updatedTask));

    Navigator.pop(context);
  }
}
