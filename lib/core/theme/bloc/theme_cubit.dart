import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task_wave/core/theme/app_colors.dart';
import 'package:task_wave/core/theme/app_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppTheme.lightTheme);

  void updateTheme(Color color, bool isDarkMode) {
    emit(ThemeData(
      primaryColor: color,
      primarySwatch: AppColors.createMaterialColor(color),
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    ));
  }

  void toggleTheme(bool isDarkMode) {
    emit(isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme);
  }
}
