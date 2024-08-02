import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:size_config/size_config.dart';
import 'package:task_wave/core/theme/app_sizes.dart';
import 'package:task_wave/core/theme/app_theme.dart';
import 'package:task_wave/core/util/constants/app_strings.dart';
import 'package:task_wave/core/util/helper_functions/extension_functions.dart';
import 'package:task_wave/core/util/helper_functions/helper_functions.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_bloc.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_event.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/base_widget.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/custom_button.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/custom_text_field.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task;

  TaskFormScreen({this.task});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool isAddToCalendar = false;

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: Column(
            children: [

              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  minimumDate: DateTime.now(),
                  initialDateTime: DateTime.now(),
                  showDayOfWeek: true,
                  onDateTimeChanged: (newTime) {
                    setState(() {
                      pickedDate = newTime;
                    });
                  },
                ),
              ),


              TextButton(onPressed: (){
                dateController.text = pickedDate!.formatToddMMMMyyHHmm();
                Navigator.pop(context);
              }, child: "Save".toTextWidget(style: context.headlineMedium)),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.name;
      _descriptionController.text = widget.task!.description;
    }
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
        title: Center(
          child: AppStrings.addTask.toTextWidget(
            style: TextStyle(
              color: context.surface,
              fontWeight: FontWeight.w400,
              fontSize: 26.sp,
            ),
          ),
        ),
      ),
    );
  }

  buildBody() {
    return Container(
      padding: EdgeInsets.only(left: 14.w, right: 14.w),
      child: Column(
        children: [
          appBar(),
          Container(
            margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 8.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    title: AppStrings.title,
                    controller: _titleController,
                    hintText: AppStrings.enterTitle,
                    leadingIcon: Icon(Icons.title),
                  ),
                  context.vGap16,
                  CustomTextField(
                    title: AppStrings.description,
                    controller: _descriptionController,
                    hintText: AppStrings.enterDescription,
                    leadingIcon: Icon(
                      Icons.description,
                    ),
                  ),
                  context.vGap16,
                  GestureDetector(
                      onTap: () {
                        _selectDateTime(context);
                      },
                      child: CustomTextField(
                        title: AppStrings.dueDate,
                        controller: dateController,
                        enabled: false,
                        hintText: AppStrings.selectDueDate,
                        leadingIcon: Icon(
                          Icons.date_range,
                        ),
                      )),
                  context.vGap16,
                  if (Platform.isAndroid)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            value: isAddToCalendar,
                            checkColor: Colors.white,
                            onChanged: (value) async {
                              requestPermissions();
                              setState(() {
                                isAddToCalendar = value!;
                              });
                            },
                            visualDensity: VisualDensity.compact,
                            side: WidgetStateBorderSide.resolveWith((states) {
                              if (states.contains(WidgetState.pressed)) {
                                return BorderSide(color: context.primary);
                              } else {
                                return BorderSide(color: context.primary);
                              }
                            }),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Add Task to Google Calendar",
                                    style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  context.vGap38,
                  CustomButton(
                      text: AppStrings.addTask,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_titleController.text != "") {
                            final task = Task(
                              id: widget.task?.id ?? DateTime.now().toString(),
                              name: _titleController.text,
                              description: _descriptionController.text,
                              comments: widget.task?.comments ?? [],
                              createdAt: currentUtcTime(),
                              userId: AppStrings.userId,
                              updatedAt: currentUtcTime(),
                              dueDate: _selectedDate.toUtc().toString(),
                              status: AppStrings.statusToDo,
                              sortOrder: 0,
                              spentTime: 0,
                              isCompleted: false,
                            );
                            if (widget.task == null) {
                              context.read<TaskBloc>().add(AddTaskEvent(
                                    task,
                                    isAddToCalendar,
                                  ));
                            } else {
                              context.read<TaskBloc>().add(UpdateTaskEvent(task));
                            }
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: AppStrings.pleaseAdd.toTextWidget(
                                      style:
                                          TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.sp)),
                                ),
                                snackBarAnimationStyle: AnimationStyle(curve: Curves.decelerate));
                          }
                        }
                      },
                      height: 48.h,
                      backGroundColor: context.primary,
                      fontWeight: FontWeight.w500,
                      borderColor: context.primary,
                      fontColor: Colors.white,
                      isEnabled: true,
                      borderRadius: 16,
                      textSize: 18.sp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidget(widget: buildBody()),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
