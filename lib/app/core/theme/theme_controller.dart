import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final isDark = false.obs;

  // WARNA UTAMA GOFOOD
  static const orange = Color(0xFFFF4B26);
  static const cream = Color(0xFFFFF8F4);

  // =============================
  // LIGHT THEME (GOFOOD STYLE)
  // =============================
  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,

        primaryColor: orange,
        scaffoldBackgroundColor: cream,

        appBarTheme: const AppBarTheme(
          backgroundColor: orange,
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            inherit: true,
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: orange, width: 2),
          ),
        ),

        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF222222),
            inherit: true,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF222222),
            inherit: true,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFF444444),
            inherit: true,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            inherit: true,
          ),
        ),
      );

  // =============================
  // DARK THEME (CUSTOM + MATCH)
  // =============================
  ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,

        primaryColor: orange,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            inherit: true,
          ),
        ),

        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            inherit: true,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            inherit: true,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.white70,
            inherit: true,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: Colors.white60,
            inherit: true,
          ),
        ),
      );

  // Pilihan theme
  ThemeData get currentTheme => isDark.value ? darkTheme : lightTheme;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDark.value = prefs.getBool('isDark') ?? false;
  }

  Future<void> toggleTheme() async {
    isDark.value = !isDark.value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', isDark.value);
  }
}
