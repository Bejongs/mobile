import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ThemeController extends GetxController {
  static const _boxName = 'theme';
  static const _keyIsDark = 'isDark';

  final RxBool isDark = false.obs;
  late Box _box;

  ThemeData get currentTheme =>
      isDark.value ? ThemeData.dark() : ThemeData.light();

  Future<void> loadTheme() async {
    _box = await Hive.openBox(_boxName);
    isDark.value = _box.get(_keyIsDark, defaultValue: false);
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
    _box.put(_keyIsDark, isDark.value);
  }
}
