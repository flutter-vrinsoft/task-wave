import 'package:flutter/material.dart';
import 'package:task_wave/core/theme/app_theme.dart';

class BaseWidget extends StatelessWidget {
  final Widget widget;
  BaseWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            context.primary.withOpacity(0.4),
            Colors.white,
            Colors.white,
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1),
        ),
      ),
      child: widget,
    );
  }
}
