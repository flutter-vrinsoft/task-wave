import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boardview/boardview_controller.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:size_config/size_config.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_wave/core/routes/app_routes.dart';
import 'package:task_wave/core/theme/app_sizes.dart';
import 'package:task_wave/core/theme/app_theme.dart';
import 'package:task_wave/core/util/constants/app_image.dart';
import 'package:task_wave/core/util/constants/app_strings.dart';
import 'package:task_wave/core/util/helper_functions/extension_functions.dart';
import 'package:task_wave/core/util/helper_functions/helper_functions.dart';
import 'package:task_wave/features/kanban_board/data/data_sources/local_datasource/task_datasource.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_bloc.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/task/bloc/task_state.dart';

class PieChartWidget extends StatefulWidget {
  PieChartWidget({super.key});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}
class _PieChartWidgetState extends State<PieChartWidget> {
  final BoardViewController boardViewController = new BoardViewController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return pieChart();
  }

  Widget pieChart() {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TaskLoaded) {
          final tasks = state.tasks;

          List<Task>? todoTasks = [];
          List<Task>? pendingTasks = [];
          List<Task>? completedTasks = [];

          todoTasks = tasks.where((element) => element.status == AppStrings.statusToDo).toList();
          pendingTasks = tasks.where((element) => element.status == AppStrings.statusPending).toList();
          completedTasks = tasks.where((element) => element.status == AppStrings.statusCompleted).toList();

          List<Color> pieColor = [
            Colors.orange,
            Colors.blue,
            Colors.green,
          ];

          Map<String, double> statusMap = {
            AppStrings.toDo: todoTasks.length.toDouble(),
            AppStrings.inProgress: pendingTasks.length.toDouble(),
            AppStrings.completed: completedTasks.length.toDouble(),
          };

          return Builder(builder: (context) {
            return Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Container(
                child: tasks.isEmpty
                    ? noData()
                    : Padding(
                        padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 16.h, bottom: 16.h),
                        child: Column(
                          children: [
                            PieChart(
                              dataMap: statusMap,
                              colorList: pieColor,
                              animationDuration: const Duration(milliseconds: 1000),
                              initialAngleInDegree: -90,
                              chartLegendSpacing: 20,
                              legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.right,
                                legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              chartValuesOptions: ChartValuesOptions(
                                chartValueStyle:
                                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.sp),
                                showChartValueBackground: false,
                                showChartValues: true,
                                showChartValuesInPercentage: true,
                                showChartValuesOutside: false,
                                decimalPlaces: 1,
                              ),
                            ),
                            context.vGap8,
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