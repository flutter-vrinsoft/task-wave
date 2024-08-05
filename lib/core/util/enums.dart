enum TaskStatusEnum {
  todo, // 1
  pending, // 2
  completed, // 3,
  none // 4,
}

enum ViewAs { list, board }

extension TaskStatusEnumExtension on String? {
  TaskStatusEnum? toTaskStatusType() {
    TaskStatusEnum? value;
    switch (this) {
      case "todo":
        value = TaskStatusEnum.todo;
        break;
      case "pending":
        value = TaskStatusEnum.pending;
        break;
      case "completed":
        value = TaskStatusEnum.completed;
        break;
      default:
        value = TaskStatusEnum.none;
        break;
    }
    return value;
  }
}
