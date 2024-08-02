import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boardview/boardview_controller.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:size_config/size_config.dart';
import 'package:task_wave/core/routes/app_routes.dart';
import 'package:task_wave/core/theme/app_colors.dart';
import 'package:task_wave/core/theme/app_sizes.dart';
import 'package:task_wave/core/theme/app_theme.dart';
import 'package:task_wave/core/util/constants/app_image.dart';
import 'package:task_wave/core/util/constants/app_strings.dart';
import 'package:task_wave/core/util/helper_functions/extension_functions.dart';
import 'package:task_wave/core/util/helper_functions/helper_functions.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_bloc.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_state.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/task_detail_page.dart';

class HorizontalTaskView extends StatefulWidget {
  HorizontalTaskView({super.key});

  @override
  State<HorizontalTaskView> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<HorizontalTaskView> {
  final BoardViewController boardViewController = new BoardViewController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return horizontalListView();
  }

  Widget horizontalListView() {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TaskLoaded) {
          final tasks = state.tasks;


          return Builder(builder: (context) {
            return Container(
              child: tasks.isEmpty
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 16.h, bottom: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.yourTasks,
                                maxLines: 1,
                                style: context.displaySmall.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 8.h, bottom: 8.h),
                                child: GestureDetector(
                                  onTap: () {
                                    pushPage(context, AppRoutes.taskRoute);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppStrings.goToTask.toTextWidget(
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: context.primary,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                      context.hGap4,
                                      Icon(
                                        Icons.arrow_circle_right_sharp,
                                        color: context.primary,
                                      )
                                    ],
                                  ),
                                ),
                              )

                            ],
                          ),
                          context.vGap8,
                          Container(
                            height: 150.h,
                            child: ListView.builder(
                              itemCount: tasks.length >= 3 ? 3 : tasks.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index) {
                                Color randomColor = Colors.white;
                                Color textColor = AppColors.textColorForBackground(
                                  randomColor,
                                );
                                Task model = tasks[index];
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => TaskDetailPage(task: model)),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.all(16.0),
                                    width: 180.w,
                                    decoration: BoxDecoration(
                                      color: randomColor.withOpacity(1.0),
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(color: context.primary)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.task_alt,
                                              color: AppColors.textColorForBackground(
                                                randomColor,
                                              ),
                                            ),
                                            context.hGap8,
                                            Flexible(
                                              child: Text("${model.name}",
                                                  maxLines: 1,
                                                  style: context.displaySmall.copyWith(
                                                    color: textColor,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Flexible(
                                          child: Text("${model.description}",
                                              maxLines: 3,
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                color: textColor,
                                              )),
                                        ),
                                        context.vGap8,
                                        Expanded(
                                          child: Wrap(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: model.status.statusColor(),
                                              ),
                                              context.hGap4,
                                              Text(
                                                "${model.status.toUpperCase()}",
                                                style: TextStyle(height: 1.5, color: textColor, fontSize: 14.sp),
                                              ),
                                            ],
                                          ),
                                        ),
                                        context.vGap8,
                                        Expanded(
                                          child: Wrap(
                                            children: [
                                              Icon(
                                                Icons.date_range,
                                                color: textColor,
                                              ),
                                              context.hGap4,
                                              Text(
                                                "${model.dueDate.toLocalDateString()}",
                                                style: TextStyle(height: 1.5, color: textColor, fontSize: 14.sp),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          });
        } else if (state is TaskError) {
          // return Center(child: Text('Failed to load tasks: ${state.error}'));
        }
        return Container();
      },
    );
  }

  Widget noData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.only(top: 32.h),
            child: Image.asset(
              AppImages.noItems,
              height: 250.h,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 8.h, bottom: 8.h),
          child: AppStrings.lookLikeDonTHaveTask.toTextWidget(
              style: TextStyle(
            fontWeight: FontWeight.w500,
            color: context.primary.withOpacity(0.8),
            fontSize: 18.sp,
          )),
        ),
        Padding(
          padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 8.h, bottom: 16.h),
          child: GestureDetector(
            onTap: () {
              pushPage(context, AppRoutes.createTaskRoute);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppStrings.addTask.toTextWidget(
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: context.primary,
                    fontSize: 18.sp,
                  ),
                ),
                context.hGap2,
                Icon(
                  Icons.add_circle,
                  color: context.primary,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
