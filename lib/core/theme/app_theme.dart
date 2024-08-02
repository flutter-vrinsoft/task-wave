import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';
import 'package:task_wave/service_locator.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      fontFamily: 'Noto Serif',
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      primaryColor: Colors.green[800], // Darker green for primary color
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.brown.shade800,
      ),
      colorScheme: const ColorScheme.light(
          primary: Colors.green,
          onPrimary: Colors.white,
          surface: Color(0xFFFAFCFF),
          onSurface: Color(0xDE04294E),
          secondary: Color.fromRGBO(237, 141, 68, 1),
          onSecondary: Colors.black,
          brightness: Brightness.light,
          tertiary: Color(0xDE04294E),
          outline: Color.fromRGBO(132, 134, 135, 1)),
      pageTransitionsTheme: pageTransitionsTheme,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: const Color(0xDE04294E), fontSize: 16.sp),
        bodyMedium: const TextStyle(color: Color(0x9904294E)),
        bodySmall: const TextStyle(color: Color(0x6104294E)),
        titleMedium: const TextStyle(color: Color(0xDE04294E)),
      ));

  static ThemeData darkTheme = ThemeData(
      fontFamily: 'Noto Serif',
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
          primary: Color(0xFF0076EB),
          surface: Color(0xFF121212),
          onSurface: Color(0xDEEDF6FF),
          secondary: Color(0xFF222222),
          onSecondary: Colors.white,
          onPrimary: Colors.white,
          tertiary: Color(0x61ECF5FE),
          outline: Colors.black),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: const Color(0xDEEDF6FF), fontSize: 16.sp),
        bodyMedium: const TextStyle(color: Color(0x99ECF5FE)),
        bodySmall: const TextStyle(color: Color(0x61ECF5FE)),
      ));
}

PageTransitionsTheme? pageTransitionsTheme = const PageTransitionsTheme(
  builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  },
);

extension ExtAppColors on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get primary => Theme.of(this).primaryColor;

  Color get secondary => colorScheme.secondary;

  Color get tertiary => colorScheme.tertiary;

  Color get primaryContainer => colorScheme.primaryContainer;

  Color get secondaryContainer => colorScheme.secondaryContainer;

  Color get tertiaryContainer => colorScheme.tertiaryContainer;

  Color get onPrimary => colorScheme.onPrimary;

  Color get onSecondary => colorScheme.onSecondary;

  Color get onTertiary => colorScheme.onTertiary;

  Color get surface => colorScheme.surface;

  Color get onSurface => colorScheme.onSurface;

  Color get surfaceTint => colorScheme.surfaceTint;

  Color get error => colorScheme.error;

  Color get onError => colorScheme.onError;

  Color get outline => colorScheme.outline;

  Color get inversePrimary => colorScheme.inversePrimary;

  Color get inverseSurface => colorScheme.inverseSurface;

  Color get onInverseSurface => colorScheme.onInverseSurface;
}

extension AppTextStyle on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get bodySmall => textTheme.bodySmall!;

  TextStyle get bodyMedium => textTheme.bodyMedium!;

  TextStyle get bodyLarge => textTheme.bodyLarge!;

  TextStyle get labelSmall => textTheme.labelSmall!;

  TextStyle get labelMedium => textTheme.labelMedium!;

  TextStyle get labelLarge => textTheme.labelLarge!;

  TextStyle get titleSmall => textTheme.titleSmall!;

  TextStyle get titleMedium => textTheme.titleMedium!;

  TextStyle get titleLarge => textTheme.titleLarge!;

  TextStyle get headlineSmall => textTheme.headlineSmall!;

  TextStyle get headlineMedium => textTheme.headlineMedium!;

  TextStyle get headlineLarge => textTheme.headlineLarge!;

  TextStyle get displaySmall => textTheme.displaySmall!;

  TextStyle get displayMedium => textTheme.displayMedium!;

  TextStyle get displayLarge => textTheme.displayLarge!;
}

extension AppTextColor on TextStyle {
  BuildContext get context => navigatorKey.currentContext!;

  TextStyle get primary => copyWith(color: Theme.of(context).colorScheme.primary);

  TextStyle get secondary => copyWith(color: Theme.of(context).colorScheme.secondary);

  TextStyle get tertiary => copyWith(color: Theme.of(context).colorScheme.tertiary);

  TextStyle get onPrimary => copyWith(color: Theme.of(context).colorScheme.onPrimary);

  TextStyle get onSecondary => copyWith(color: Theme.of(context).colorScheme.onSecondary);

  TextStyle get onTertiary => copyWith(color: Theme.of(context).colorScheme.onTertiary);

  TextStyle get surface => copyWith(color: Theme.of(context).colorScheme.surface);

  TextStyle get onSurface => copyWith(color: Theme.of(context).colorScheme.onSurface);

  TextStyle get surfaceTint => copyWith(color: Theme.of(context).colorScheme.surfaceTint);

  TextStyle get error => copyWith(color: Theme.of(context).colorScheme.error);

  TextStyle get onError => copyWith(color: Theme.of(context).colorScheme.onError);

  TextStyle get outline => copyWith(color: Theme.of(context).colorScheme.outline);

  TextStyle get inversePrimary => copyWith(color: Theme.of(context).colorScheme.inversePrimary);

  TextStyle get inverseSurface => copyWith(color: Theme.of(context).colorScheme.inverseSurface);

  TextStyle get onInverseSurface => copyWith(color: Theme.of(context).colorScheme.onInverseSurface);

  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
}
