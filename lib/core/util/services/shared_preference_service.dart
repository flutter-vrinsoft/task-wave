import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? instance;
  static SharedPreferences? preferences;

  SharedPreferencesService();

  static Future<SharedPreferencesService?> getInstance() async {
    instance ??= SharedPreferencesService();

    preferences ??= await SharedPreferences.getInstance();

    return instance;
  }

// Keys for your shared preferences
  static String isFirstTimeKey = 'is_first_time_key';
  static String userNameKey = 'user_name_key';
  static String themeColorKey = 'theme_color_key';
  static String isDarkModeKey = 'is_dark_mode_key';
  static String selectedLanguageKey = 'selected_language_key';

// Getters and setters for shared preferences values
  String? get userName => preferences?.getString(userNameKey) ?? '';
  set userName(String? value) => preferences?.setString(userNameKey, value ?? '');

  String? get themeColor => preferences?.getString(themeColorKey) ?? '';
  set themeColor(String? value) => preferences?.setString(themeColorKey, value ?? '');

  bool? get isDarkMode => preferences?.getBool(isDarkModeKey) ?? false;
  set isDarkMode(value) => preferences?.setBool(isDarkModeKey, value ?? false);

  bool? get isFirstTime => preferences?.getBool(isFirstTimeKey) ?? true;
  set isFirstTime(value) => preferences?.setBool(isFirstTimeKey, value ?? false);

  String? get selectedLanguage => preferences?.getString(selectedLanguageKey) ?? '';
  set selectedLanguage(String? value) => preferences?.setString(selectedLanguageKey, value ?? '');

// Clear all shared preferences
}
