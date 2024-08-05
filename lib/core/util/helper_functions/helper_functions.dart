import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task_wave/core/util/helper_functions/extension_functions.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';

navTo(BuildContext context, String route) {
  GoRouter.of(context).go(route);
}

pushPage(BuildContext context, String route) {
  GoRouter.of(context).push(route);
}

replacePage(BuildContext context, String route) {
  GoRouter.of(context).replace(route);
}

String currentUtcTime() {
  return DateTime.now().toUtc().toString();
}

void addToCalendar(Task task) async {

  final intent = AndroidIntent(
    action: 'android.intent.action.INSERT', // Important
    data: 'content://com.android.calendar/event', // Important
    type: "vnd.android.cursor.dir/event", // Important
    arguments: <String, dynamic>{
      'title': task.name,
      'allDay': true,
      'beginTime': task.createdAt.toMiliSeconds(),
      'endTime': task.dueDate.toMiliSeconds(),
      'description': task.description,
      'eventLocation': "",
      'hasAlarm': 1,
      'calendar_id': 1,
      'eventTimezone': '${await FlutterTimezone.getLocalTimezone()}'
    },
  );

  intent.launch();
}

void addToCalendar1(Task task) async {

  try {
    /*  String localTimezone = await FlutterTimezone.getLocalTimezone();

    final eventID = await platform.invokeMethod('addCalendarEvent', {
      'title': task.name,
      'allDay': true,
      'beginTime': task.createdAt.toMiliSeconds(),
      'endTime': task.dueDate.toMiliSeconds(),
      'description': task.description,
      'location': '',
      'hasAlarm': true,
      'timezone': localTimezone,
    });
    print('Event created with ID: $eventID ${task.dueDate.toMiliSeconds()}');
*/
  } on PlatformException catch (e) {
    print("Failed to create event: '${e.message}'.");
  }
}

Future<bool> requestPermissions() async {
  PermissionStatus calendarPermissionStatus = await Permission.calendarWriteOnly.request();
  return calendarPermissionStatus.isGranted;
}
