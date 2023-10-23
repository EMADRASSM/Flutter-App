import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorage {
  final String _key = 'theme_mode';

  // Save the theme mode preference.
  Future<void> saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, isDarkMode);
  }

  // Retrieve the theme mode preference.
  Future<bool> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }
}
