import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends GetxController {
  final RxBool isDarkMode = false.obs;
  static const _key = "is_dark_mode";

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool(_key) ?? false;
  }

  Future<void> toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, isDarkMode.value);
  }
}
