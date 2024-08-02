import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:task_wave/core/theme/bloc/theme_cubit.dart';

void main() {
  group('ThemeCubit Tests', () {
    blocTest<ThemeCubit, ThemeData>(
      'emits ThemeState.light when toggled from dark',
      build: () => ThemeCubit(),
      act: (cubit) => cubit.toggleTheme(true),
      expect: () => [ThemeData.light()],
    );

    blocTest<ThemeCubit, ThemeData>(
      'emits ThemeState.dark when toggled from light',
      build: () => ThemeCubit()..toggleTheme(true),
      act: (cubit) => cubit.toggleTheme(false),
      expect: () => [ThemeData.dark()],
    );
  });
}