import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            style: GoogleFonts.badScript(textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.tertiary,
              fontSize: 32.sp,
            )),
          ),
          TextSpan(
            text: " ",
            style: GoogleFonts.alexBrush(textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.tertiary,
              fontSize: 32.sp,
            )) ,
          ),
          TextSpan(
            text: AppStrings.userName,
            style: GoogleFonts.badScript(textStyle: GoogleFonts.alexBrush(textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.primary.withOpacity(
                  0.8,
                ),
                fontSize: 28.sp))),
          ),
        ])),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: AppStrings.goodToSeeYou,
                style: GoogleFonts.dancingScript(textStyle: GoogleFonts.alexBrush(textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.tertiary,
                  fontSize: 32.sp,
                ))),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
