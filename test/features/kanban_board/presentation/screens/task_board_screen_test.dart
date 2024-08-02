import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/task_board_widget.dart';

void main() {
  testWidgets('Task Board Widget displays task columns', (WidgetTester tester) async {
    // Arrange

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TaskBoardWidget(),
      ),
    ));

    // Assert
    expect(find.text('To Do'), findsOneWidget);
    expect(find.text('In Progress'), findsOneWidget);
    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Task 2'), findsOneWidget);
  });
}
