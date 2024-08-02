import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:size_config/size_config.dart';
import 'package:task_wave/core/theme/app_sizes.dart';
import 'package:task_wave/core/theme/app_theme.dart';
import 'package:task_wave/core/util/helper_functions/extension_functions.dart';

class ClockDigWidget extends StatefulWidget {
  const ClockDigWidget({super.key});

  @override
  State<ClockDigWidget> createState() => _ClockDigWidgetState();
}

class _ClockDigWidgetState extends State<ClockDigWidget> {
  String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        formattedTime = DateFormat('hh:mm:ss a').format(DateTime.now());
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: clockWidget(),
        ),
        Expanded(flex: 1, child: dateWidget(context)),
      ],
    );
  }

  Widget clockWidget() {
    return Card(
      color: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        height: 70.h,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.timer,
              size: 30,
            ),
            formattedTime.toTextWidget(style: context.titleLarge.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget dateWidget(BuildContext context) {
    String dayOfWeek = DateFormat('EEEE').format(DateTime.now());
    String date = DateFormat('MMMM d yyyy').format(DateTime.now());

    return Card(
      color: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        height: 70.h,
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dayOfWeek.toTextWidget(style: context.titleLarge.copyWith(fontWeight: FontWeight.bold)),
                date.toTextWidget(style: context.titleMedium),
              ],
            ),
            Icon(
              Icons.calendar_month_sharp,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}
