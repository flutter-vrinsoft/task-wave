import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:size_config/size_config.dart';
import 'package:task_wave/core/theme/app_sizes.dart';
import 'package:task_wave/core/theme/app_theme.dart';
import 'package:task_wave/core/theme/bloc/theme_cubit.dart';
import 'package:task_wave/core/util/constants/app_strings.dart';
import 'package:task_wave/core/util/helper_functions/extension_functions.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/base_widget.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/clock_widget.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/horizontal_task_view.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/pie_chart_widget.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/welcome_widget.dart';
import 'package:upgrader/upgrader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  appBar() {
    return Container(
      width: AppSizes.screenWidth,
      margin: EdgeInsets.only(top: kToolbarHeight),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: context.onInverseSurface,
          child: IconButton(
            onPressed: () {
              _showColorPickerDialog(context);
            },
            icon: Icon(Icons.format_paint),
          ),
        ),
        trailing: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // CircleAvatar(
              //   backgroundColor: context.onInverseSurface,
              //   child: IconButton(
              //     onPressed: () async {
              //       await _showRateUsDialog(context);
              //     },
              //     icon: Icon(Icons.star, color: Colors.yellow),
              //   ),
              // ),
              // context.hGap10,
              // CircleAvatar(
              //   backgroundColor: context.onInverseSurface,
              //   child: IconButton(
              //     onPressed: () async {
              //       await _showUpdateDialog(context);
              //     },
              //     icon: Icon(Icons.update, color: context.primary),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Container(
      padding: EdgeInsets.only(left: 14.w, right: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appBar(),
          Container(
              padding: EdgeInsets.only(
                left: 24.w,
                top: 14.w,
              ),
              child: WelcomeWidget()),
          context.vGap16,
          ClockDigWidget(),
          HorizontalTaskView(),
          context.vGap8,
          PieChartWidget(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(child: BaseWidget(widget: buildBody())),
    );
  }
}

void _showColorPickerDialog(BuildContext context) {
  Color selectedColor = Theme.of(context).primaryColor;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: AppStrings.pickAColor.toTextWidget(),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              selectedColor = color;
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppStrings.cancel.toTextWidget(),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: AppStrings.select.toTextWidget(),
            onPressed: () {
              context.read<ThemeCubit>().updateTheme(selectedColor, false);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showRateUsDialog(BuildContext context) async {
  // final InAppReview _inAppReview = InAppReview.instance;
  // if (await _inAppReview.isAvailable()) {
  //   _inAppReview.requestReview();
  // } else {
  //   // Fallback for platforms that do not support in-app review
  //   _inAppReview.openStoreListing(appStoreId: 'YOUR_APP_STORE_ID', microsoftStoreId: 'YOUR_MICROSOFT_STORE_ID');
  // }
}

Future<void> _showUpdateDialog(BuildContext context) async {
  Upgrader.clearSavedSettings();

  // return showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return UpgradeAlert(
  //       barrierDismissible: true,
  //       dialogStyle: UpgradeDialogStyle.material, // Use Material design for the dialog
  //     );
  //   },
  // );
}
