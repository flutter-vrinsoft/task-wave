import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class AppSizes {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
    _safeAreaHorizontal = mediaQueryData!.padding.left + mediaQueryData!.padding.right;
    _safeAreaVertical = mediaQueryData!.padding.top + mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;
  }
}

extension AppSize on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;
}

extension SizedBoxes on BuildContext {
  Widget get vGap0 => SizedBox.shrink();

  Widget get vGap2 => SizedBox(
        height: 2.h,
      );

  Widget get vGap4 => SizedBox(
        height: 4.h,
      );

  Widget get vGap6 => SizedBox(
        height: 6.h,
      );

  Widget get vGap8 => SizedBox(
        height: 8.h,
      );

  Widget get vGap10 => SizedBox(
        height: 10.h,
      );

  Widget get vGap12 => SizedBox(
        height: 12.h,
      );

  Widget get vGap14 => SizedBox(
        height: 14.h,
      );

  Widget get vGap16 => SizedBox(
        height: 16.h,
      );

  Widget get vGap18 => SizedBox(
        height: 18.h,
      );

  Widget get vGap20 => SizedBox(
        height: 20.h,
      );

  Widget get vGap22 => SizedBox(
        height: 22.h,
      );

  Widget get vGap24 => SizedBox(
        height: 24.h,
      );

  Widget get vGap26 => SizedBox(
        height: 26.h,
      );

  Widget get vGap28 => SizedBox(
        height: 28.h,
      );

  Widget get vGap30 => SizedBox(
        height: 30.h,
      );

  Widget get vGap32 => SizedBox(
        height: 32.h,
      );

  Widget get vGap34 => SizedBox(
        height: 34.h,
      );

  Widget get vGap36 => SizedBox(
        height: 36.h,
      );

  Widget get vGap38 => SizedBox(
        height: 38.h,
      );

  Widget get vGap40 => SizedBox(
        height: 40.h,
      );

  Widget get vGap42 => SizedBox(
        height: 42.h,
      );

  Widget get vGap44 => SizedBox(
        height: 44.h,
      );

  Widget get vGap46 => SizedBox(
        height: 46.h,
      );

  Widget get vGap48 => SizedBox(
        height: 48.h,
      );

  Widget get vGap50 => SizedBox(
        height: 50.h,
      );

  Widget get vGap52 => SizedBox(
        height: 52.h,
      );

  Widget get vGap54 => SizedBox(
        height: 54.h,
      );

  Widget get vGap56 => SizedBox(
        height: 56.h,
      );

  Widget get vGap58 => SizedBox(
        height: 58.h,
      );

  Widget get vGap60 => SizedBox(
        height: 60.h,
      );

  Widget get vGap62 => SizedBox(
        height: 62.h,
      );

  Widget get vGap64 => SizedBox(
        height: 64.h,
      );

  Widget get vGap66 => SizedBox(
        height: 66.h,
      );

  Widget get vGap68 => SizedBox(
        height: 68.h,
      );

  Widget get vGap70 => SizedBox(
        height: 70.h,
      );

  Widget get vGap72 => SizedBox(
        height: 72.h,
      );

  Widget get vGap74 => SizedBox(
        height: 74.h,
      );

  Widget get vGap76 => SizedBox(
        height: 76.h,
      );

  Widget get vGap78 => SizedBox(
        height: 78.h,
      );

  Widget get vGap80 => SizedBox(
        height: 80.h,
      );

  Widget get vGap82 => SizedBox(
        height: 82.h,
      );

  Widget get vGap84 => SizedBox(
        height: 84.h,
      );

  Widget get vGap86 => SizedBox(
        height: 86.h,
      );

  Widget get vGap88 => SizedBox(
        height: 88.h,
      );

  Widget get vGap90 => SizedBox(
        height: 90.h,
      );

  Widget get vGap92 => SizedBox(
        height: 92.h,
      );

  Widget get vGap94 => SizedBox(
        height: 94.h,
      );

  Widget get vGap96 => SizedBox(
        height: 96.h,
      );

  Widget get vGap98 => SizedBox(
        height: 98.h,
      );

  Widget get hGap2 => SizedBox(
        width: 2.w,
      );

  Widget get hGap4 => SizedBox(
        width: 4.w,
      );

  Widget get hGap6 => SizedBox(
        width: 6.w,
      );

  Widget get hGap8 => SizedBox(
        width: 8.w,
      );

  Widget get hGap10 => SizedBox(
        width: 10.w,
      );

  Widget get hGap12 => SizedBox(
        width: 12.w,
      );

  Widget get hGap14 => SizedBox(
        width: 14.w,
      );

  Widget get hGap16 => SizedBox(
        width: 16.w,
      );

  Widget get hGap18 => SizedBox(
        width: 18.w,
      );

  Widget get hGap20 => SizedBox(
        width: 20.w,
      );

  Widget get hGap22 => SizedBox(
        width: 22.w,
      );

  Widget get hGap24 => SizedBox(
        width: 24.w,
      );

  Widget get hGap26 => SizedBox(
        width: 26.w,
      );

  Widget get hGap28 => SizedBox(
        width: 28.w,
      );

  Widget get hGap30 => SizedBox(
        width: 30.w,
      );

  Widget get hGap32 => SizedBox(
        width: 32.w,
      );

  Widget get hGap34 => SizedBox(
        width: 34.w,
      );

  Widget get hGap36 => SizedBox(
        width: 36.w,
      );

  Widget get hGap38 => SizedBox(
        width: 38.w,
      );

  Widget get hGap40 => SizedBox(
        width: 40.w,
      );

  Widget get hGap42 => SizedBox(
        width: 42.w,
      );

  Widget get hGap44 => SizedBox(
        width: 44.w,
      );

  Widget get hGap46 => SizedBox(
        width: 46.w,
      );

  Widget get hGap48 => SizedBox(
        width: 48.w,
      );

  Widget get hGap50 => SizedBox(
        width: 50.w,
      );

  Widget get hGap52 => SizedBox(
        width: 52.w,
      );

  Widget get hGap54 => SizedBox(
        width: 54.w,
      );

  Widget get hGap56 => SizedBox(
        width: 56.w,
      );

  Widget get hGap58 => SizedBox(
        width: 58.w,
      );

  Widget get hGap60 => SizedBox(
        width: 60.w,
      );

  Widget get hGap62 => SizedBox(
        width: 62.w,
      );

  Widget get hGap64 => SizedBox(
        width: 64.w,
      );

  Widget get hGap66 => SizedBox(
        width: 66.w,
      );

  Widget get hGap68 => SizedBox(
        width: 68.w,
      );

  Widget get hGap70 => SizedBox(
        width: 70.w,
      );

  Widget get hGap72 => SizedBox(
        width: 72.w,
      );

  Widget get hGap74 => SizedBox(
        width: 74.w,
      );

  Widget get hGap76 => SizedBox(
        width: 76.w,
      );

  Widget get hGap78 => SizedBox(
        width: 78.w,
      );

  Widget get hGap80 => SizedBox(
        width: 80.w,
      );

  Widget get hGap82 => SizedBox(
        width: 82.w,
      );

  Widget get hGap84 => SizedBox(
        width: 84.w,
      );

  Widget get hGap86 => SizedBox(
        width: 86.w,
      );

  Widget get hGap88 => SizedBox(
        width: 88.w,
      );

  Widget get hGap90 => SizedBox(
        width: 90.w,
      );

  Widget get hGap92 => SizedBox(
        width: 92.w,
      );

  Widget get hGap94 => SizedBox(
        width: 94.w,
      );

  Widget get hGap96 => SizedBox(
        width: 96.w,
      );

  Widget get hGap98 => SizedBox(
        width: 98.w,
      );
}
