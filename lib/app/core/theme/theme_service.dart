import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const _keyIsDark = 'is_dark_theme';

  Future<bool> loadIsDark() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsDark) ?? false;
  }

  Future<void> saveIsDark(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsDark, value);
  }
}
