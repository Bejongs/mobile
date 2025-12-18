import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive/hive.dart';

import '../../../core/constants/admin_emails.dart';
import 'package:demo_modul4/app/routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final passwordHidden = true.obs;
  final rememberMe = false.obs;

  final supabase = Supabase.instance.client;
  late Box authBox;

  @override
  void onInit() {
    super.onInit();
    authBox = Hive.box('auth');
    rememberMe.value = authBox.get('remember_me', defaultValue: false);
  }

  void togglePassword() {
    passwordHidden.value = !passwordHidden.value;
  }

  void toggleRemember(bool value) {
    rememberMe.value = value;
  }

  Future<void> doLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan password tidak boleh kosong");
      return;
    }

    try {
      isLoading.value = true;

      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // 👇 SIMPAN INGAT SAYA
      authBox.put('remember_me', rememberMe.value);

      Get.offAllNamed(Routes.MAIN);
    } catch (e) {
      Get.snackbar("Login gagal", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
    authBox.clear();
    Get.offAllNamed('/login');
  }
}
