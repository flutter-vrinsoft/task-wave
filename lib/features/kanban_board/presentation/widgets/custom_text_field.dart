import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';
import 'package:task_wave/core/theme/app_sizes.dart';
import 'package:task_wave/core/theme/app_theme.dart';
import 'package:task_wave/core/util/helper_functions/extension_functions.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String? hintText;
  final bool? enabled;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget? trailingIcon;
  final Widget? leadingIcon;

  CustomTextField({
    this.leadingIcon,
    this.trailingIcon,
    this.enabled,
    this.hintText,
    required this.controller,
    required this.title,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.toTextWidget(style: TextStyle(color: context.primary, fontSize: 18.sp, fontWeight: FontWeight.w600)),
        context.vGap4,
        Container(
          height: 43.h,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: context.primary)),
          child: TextFormField(
            controller: controller,
            enabled: enabled ?? true,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
            ),
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                hintText: hintText ?? '',
                prefixIcon: leadingIcon ?? null,
                hintStyle: TextStyle(
                  color: Colors.black26,
                  fontSize: 16.sp,
                ),
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(9)),
          ),
        ),
      ],
    );
  }
}
