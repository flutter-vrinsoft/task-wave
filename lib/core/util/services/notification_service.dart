import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  init() async {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    initializetimezone();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future initializetimezone() async {
    tz.initializeTimeZones();
    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> scheduleNotification(Task task) async {
    final DateTime dueDate = DateTime.parse(task.dueDate).toLocal();
    final tz.TZDateTime scheduledDate = tz.TZDateTime.local(
      dueDate.year,
      dueDate.month,
      dueDate.day,
      dueDate.hour,
      dueDate.minute,
      dueDate.second,
      dueDate.millisecond,
      dueDate.microsecond,
    ).add(Duration(seconds: 1));

    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'main_channel',
      'main channel',
      channelDescription: 'main channel description',
      importance: Importance.max,
      priority: Priority.high,
    );
    DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails(
      sound: 'default.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);

    try {
      // print("due date111 ${dueDate.toString()}");
      await flutterLocalNotificationsPlugin.zonedSchedule(
        task.hashCode,
        'Task Due: ${task.name}',
        'Your task "${task.name}" is due.',
        scheduledDate,
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    } catch (e) {
      debugPrint("Error at zonedScheduleNotification----------------------------$e");
      if (e == "Invalid argument (scheduledDate): Must be a date in the future: Instance of 'TZDateTime'") {}
    }
    ;
  }
}
