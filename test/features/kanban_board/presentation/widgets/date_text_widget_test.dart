import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/date_text_widget.dart';

void main() {
  testWidgets('Date Text Widget displays formatted date', (WidgetTester tester) async {
    // Arrange

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DateTextWidget(),
      ),
    ));

    // Assert
    expect(find.text('23 Jul 2023'), findsOneWidget);
  });
}