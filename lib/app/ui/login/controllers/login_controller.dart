import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constants/admin_emails.dart';
import 'package:demo_modul4/app/routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  // 🔥 Tambahkan ini untuk fitur show/hide password
  final passwordHidden = true.obs;

  final supabase = Supabase.instance.client;

  Future<void> doLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan password tidak boleh kosong");
      return;
    }

    try {
      isLoading.value = true;

      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final userEmail = res.user?.email ?? "";

      // CEK ADMIN
      if (adminEmails.contains(userEmail)) {
        Get.offAllNamed('/admin-menu');
      } else {
        Get.offAllNamed(Routes.MAIN);
      }

    } catch (e) {
      Get.snackbar("Login gagal", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar("Error", "Gagal logout: $e");
    }
  }
}
