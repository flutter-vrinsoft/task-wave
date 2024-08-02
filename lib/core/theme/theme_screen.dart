import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:task_wave/core/theme/app_theme.dart';
import 'package:task_wave/core/theme/bloc/theme_cubit.dart';

class ThemeScreen extends StatefulWidget {
  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Theme Cubit with Color Picker',
            style: context.bodyLarge.copyWith(
              color: Colors.black,
            )),
        actions: [
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
              context.read<ThemeCubit>().toggleTheme(isDarkMode);
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showColorPickerDialog(context);
          },
          child: Text('Select', style: context.bodyLarge.copyWith(color: context.primary)),
        ),
      ),
    );
  }

  void _showColorPickerDialog(BuildContext context) {
    Color selectedColor = Theme.of(context).primaryColor;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
                debugPrint("selected Color ${selectedColor.value}");
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Select'),
              onPressed: () {
                context.read<ThemeCubit>().updateTheme(selectedColor, isDarkMode);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
