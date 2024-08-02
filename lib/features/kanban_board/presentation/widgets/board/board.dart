import 'package:task_wave/features/kanban_board/data/models/task.dart';

class BoardListObject {
  String title;
  List<Task> items = [];

  BoardListObject({required this.items, required this.title});
}

class BoardItemObject {
  String title;
  String from;

  BoardItemObject({this.title = "", this.from = ""});
}
