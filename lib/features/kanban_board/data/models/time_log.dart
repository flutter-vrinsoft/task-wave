import 'package:hive/hive.dart';

part 'time_log.g.dart';

@HiveType(typeId: 3)
class TimeLog extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String taskId;

  @HiveField(2)
  final DateTime startTime;

  @HiveField(3)
  final DateTime endTime;

  TimeLog({
    required this.userId,
    required this.taskId,
    required this.startTime,
    required this.endTime,
  });
}
