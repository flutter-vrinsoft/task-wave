import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:task_wave/features/kanban_board/presentation/pages/home_screen.dart/home_screen.dart';

void main() {
  testWidgets('Home Screen displays welcome message', (WidgetTester tester) async {
    // Arrange

    // Act
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(),
    ));

    // Assert
    expect(find.text('Welcome to Home Screen'), findsOneWidget);
  });
}