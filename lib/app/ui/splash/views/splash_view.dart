import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      final session = Supabase.instance.client.auth.currentSession;
      final authBox = Hive.box('auth');
      final rememberMe = authBox.get('remember_me', defaultValue: false);

      if (rememberMe && session != null) {
        Get.offAllNamed('/main');   // sudah login & ingat saya
      } else {
        Get.offAllNamed('/login');  // belum / tidak ingat saya
      }
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
