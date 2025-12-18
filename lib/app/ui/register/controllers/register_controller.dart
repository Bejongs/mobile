import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final supabase = Supabase.instance.client;
  final isLoading = false.obs;

  Future<void> doRegister() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan password wajib diisi");
      return;
    }

    try {
      isLoading.value = true;
      await supabase.auth.signUp(email: email, password: password);
      Get.snackbar("Berhasil", "Akun berhasil dibuat");
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar("Register gagal", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
