import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_wave/features/kanban_board/presentation/widgets/custom_button.dart';

void main() {
  testWidgets('Custom Button triggers onPressed callback', (WidgetTester tester) async {
    var wasPressed = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomButton(
          text: 'Press Me',
          onPressed: () {
            wasPressed = true;
          },
          backGroundColor: Colors.blue,
          fontWeight: FontWeight.w500,
          borderColor: Colors.blue,
          fontColor: Colors.white,
          isEnabled: true,
          borderRadius: 6,
          textSize: 18,
        ),
      ),
    ));

    expect(find.text('Press Me'), findsOneWidget);

    await tester.tap(find.byType(CustomButton));
    await tester.pump();

    expect(wasPressed, isTrue);
  });
}
