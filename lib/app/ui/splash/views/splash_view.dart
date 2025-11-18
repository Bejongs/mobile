import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () async {
      final session = Supabase.instance.client.auth.currentSession;

      if (session == null) {
        Get.offAllNamed('/login');      // belum login
      } else {
        Get.offAllNamed('/menu');       // sudah login → user
      }
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

