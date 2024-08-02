import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:task_wave/core/util/constants/app_strings.dart';

extension ExtensionsOnNullableInt on int? {
  String? fromTimestampToDate() {
    if (this != null) {
      final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this! * 1000);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    }
    return null;
  }

  String? fromTimestampToTime() {
    if (this != null) {
      final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this! * 1000);
      return DateFormat.Hms().format(dateTime);
    }
    return null;
  }

  String formatDuration() {
    String time = '';
    int hours = (this! / 3600).floor();
    int minutes = ((this! % 3600) / 60).floor();
    int seconds = this! % 60;

    if (hours > 0) {
      time =
          "${hours.toString().padLeft(2, '0')} h ${minutes.toString().padLeft(2, '0')} m ${seconds.toString().padLeft(2, '0')} s";
    }
    if (hours == 0 && minutes > 0) {
      time = "${minutes.toString().padLeft(2, '0')} m ${seconds.toString().padLeft(2, '0')} s";
    } else if (minutes == 0 && seconds > 0) {
      time = "${seconds.toString().padLeft(2, '0')} s";
    } else {
      time = "0 s";
    }
    return time;
  }
}

extension ExtensionsOnString on String {
  Uri parseUri({Map<String, dynamic>? params}) {
    return Uri.parse(
      this,
    ).replace(
      queryParameters: params?.map(
        (String key, dynamic value) => MapEntry<String, dynamic>(
          key,
          value.toString(),
        ),
      ),
    );
  }

  Color statusColorCard() {
    Color statusColor = Colors.yellow;

    if (this.toLowerCase() == 'todo') {
      statusColor = Colors.orange;
    }
    if (this.toLowerCase() == 'pending') {
      statusColor = Colors.blue;
    }
    if (this.toLowerCase() == 'completed') {
      statusColor = Colors.green;
    }

    return statusColor;
  }

  String status() {
    String status = "";

    if (this.toLowerCase() == AppStrings.statusToDo) {
      status = AppStrings.toDo;
    }
    if (this.toLowerCase() == AppStrings.statusPending) {
      status = AppStrings.inProgress;
    }
    if (this.toLowerCase() == AppStrings.statusCompleted) {
      status = AppStrings.completed;
    }

    return status;
  }

  Color statusColor() {
    Color statusColor = Colors.yellow;

    if (this.toLowerCase() == AppStrings.statusToDo) {
      statusColor = Colors.yellow.withOpacity(0.7);
    }
    if (this.toLowerCase() == AppStrings.statusPending) {
      statusColor = Colors.orange;
    }
    if (this.toLowerCase() == AppStrings.statusCompleted) {
      statusColor = Colors.green;
    }

    return statusColor;
  }

  int toMiliSeconds() {
    DateTime utcDateTime = DateTime.parse(this).toLocal();
    print("${utcDateTime.toString()}");
    return utcDateTime.millisecondsSinceEpoch;
  }

  String toLocalDateString({String format = 'dd MMM yyyy'}) {
    try {
      // Parse the UTC date string into a DateTime object
      DateTime utcDateTime = DateTime.parse(this);

      // Convert the UTC DateTime to local DateTime
      DateTime localDateTime = utcDateTime.toLocal();

      // Format the local DateTime
      return DateFormat(format).format(localDateTime);
    } catch (e) {
      // Handle parsing errors
      return 'Invalid date';
    }
  }

  /// Compare txo string convert them in lowerCase
  bool isEqual(String? value) {
    return toLowerCase() == value?.toLowerCase();
  }

  Widget toTextWidget({TextStyle? style, TextAlign? textAlign}) {
    return Text(
      this,
      style: style ?? null,
      textAlign: textAlign ?? null,
    );
  }
}

extension ExtensionsOnHttpResponse on Response {
  dynamic decodeJson() {
    return jsonDecode(body);
  }
}

extension ExtensionsOnDate on DateTime {
  bool isDateEqual(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  bool isMonthEqual(DateTime date) {
    return year == date.year && month == date.month;
  }

  String formatToddMMMMyy() {
    return DateFormat('dd MMMM yyyy').format(this);
  }

  String formatToddMMMMyyHHmm() {
    return DateFormat('dd MMMM yyyy hh:mm a').format(this);
  }
}
