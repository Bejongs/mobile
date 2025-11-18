import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final isDark = false.obs;

  ThemeData get currentTheme =>
      isDark.value ? ThemeData.dark() : ThemeData.light();

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDark.value = prefs.getBool('isDark') ?? false;
  }

  Future<void> toggleTheme() async {
    isDark.value = !isDark.value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark.value);
  }
}
