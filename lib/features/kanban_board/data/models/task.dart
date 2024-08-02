import 'package:hive/hive.dart';
import 'comment.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String userId;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String createdAt;

  @HiveField(5)
  final String updatedAt;

  @HiveField(6)
  final String dueDate;

  @HiveField(7)
  final String status;

  @HiveField(8)
  final int sortOrder;

  @HiveField(9)
  final int spentTime;

  @HiveField(10)
  final bool isCompleted;

  @HiveField(11)
  final List<Comment> comments;


  Task({
    required this.id,
    required this.name,
    required this.userId,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.dueDate,
    required this.status,
    required this.sortOrder,
    required this.spentTime,
    required this.isCompleted,
    required this.comments,
  });

  Task copyWith({
    String? id,
    String? name,
    String? userId,
    String? description,
    String? createdAt,
    String? updatedAt,
    String? dueDate,
    String? status,
    int? sortOrder,
    int? spentHours,
    bool? isCompleted,
    List<Comment>? comments,
    String? endTime,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      sortOrder: sortOrder ?? this.sortOrder,
      spentTime: spentHours ?? this.spentTime,
      isCompleted: isCompleted ?? this.isCompleted,
      comments: comments ?? this.comments,
    );
  }
}
