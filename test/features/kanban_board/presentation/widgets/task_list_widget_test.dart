
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/task_list_widget.dart';

void main() {
  testWidgets('Task List Widget displays tasks correctly', (WidgetTester tester) async {
    // Arrange

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TaskListWidget(),
      ),
    ));

    // Assert
    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Description 1'), findsOneWidget);
    expect(find.text('Task 2'), findsOneWidget);
    expect(find.text('Description 2'), findsOneWidget);
  });
}