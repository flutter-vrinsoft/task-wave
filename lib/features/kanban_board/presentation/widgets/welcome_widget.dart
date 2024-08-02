import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';
import 'package:task_wave/core/theme/app_sizes.dart';
import 'package:task_wave/core/theme/app_theme.dart';
import 'package:task_wave/core/util/constants/app_strings.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: AppStrings.hello,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.tertiary,
              fontSize: 32.sp,
            ),
          ),
          TextSpan(
            text: " ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.primary.withOpacity(
                  0.8,
                ),
                fontSize: 28.sp),
          ),
          TextSpan(
            text: AppStrings.userName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.primary.withOpacity(
                  0.8,
                ),
                fontSize: 28.sp),
          ),
        ])),
        context.vGap8,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: AppStrings.goodToSeeYou,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: context.onInverseSurface,
                  fontSize: 24.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
