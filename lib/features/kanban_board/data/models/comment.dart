import 'package:hive/hive.dart';

part 'comment.g.dart';

@HiveType(typeId: 2)
class Comment extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String taskId;

  @HiveField(2)
  final String content;

  Comment({required this.userId, required this.taskId, required this.content});
}
