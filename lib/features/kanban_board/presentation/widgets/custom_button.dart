import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:size_config/size_config.dart';
import 'package:task_wave/core/theme/app_theme.dart';
import 'package:task_wave/core/util/helper_functions/extension_functions.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String? text;
  final Color backGroundColor;
  final double borderRadius;
  final Color borderColor;
  final Color fontColor;
  final FontWeight fontWeight;
  final double textSize;
  double? height;
  Widget? titleWidget;
  final Function() onPressed;
  bool? isLoading = false;
  bool isEnabled = false;

  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
    this.titleWidget,
    this.isLoading,
    required this.backGroundColor,
    required this.fontWeight,
    required this.borderColor,
    required this.fontColor,
    required this.isEnabled,
    required this.borderRadius,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: !isEnabled
          ? ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  side: BorderSide(
                    color: Colors.grey.shade400,
                  ))),
              minimumSize: WidgetStateProperty.all<Size>(Size.fromHeight(height ?? 40)),
              backgroundColor: WidgetStateProperty.all<Color>(Colors.grey.shade400),
              elevation: WidgetStateProperty.all<double>(0))
          : ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  side: BorderSide(
                    color: borderColor,
                  ))),
              minimumSize: WidgetStateProperty.all<Size>(Size.fromHeight(height ?? 40)),
              backgroundColor: WidgetStateProperty.all<Color>(backGroundColor),
              elevation: WidgetStateProperty.all<double>(0)),
      onPressed: () {
        if (isEnabled) {
          onPressed();
        }
      },
      child: isLoading != null
          ? isLoading!
              ? SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : titleWidget ??
                  text!.toTextWidget(
                    style: context.bodyMedium.copyWith(color: fontColor, fontSize: textSize, fontWeight: fontWeight),
                  )
          : titleWidget ??
              text!.toTextWidget(
                style: context.bodyMedium.copyWith(color: fontColor, fontSize: textSize, fontWeight: fontWeight),
              ),
    );
  }
}

class CustomImageButton extends StatelessWidget {
  final double? height, width;
  final Function()? onTap;
  final BoxFit? fit;
  final String image;

  const CustomImageButton({
    super.key,
    required this.image,
    required this.onTap,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: SvgPicture.asset(
        image,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      ),
    );
  }
}
