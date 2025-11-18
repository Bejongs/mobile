import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/auth_provider.dart';

class RegisterController extends GetxController {
  final AuthProvider _auth = AuthProvider();

  final email = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;

  Future<void> doRegister() async {
    if (email.value.trim().isEmpty || password.value.isEmpty) {
      Get.snackbar('Gagal', 'Email dan password harus diisi');
      return;
    }

    try {
      isLoading.value = true;
      await _auth.signUp(email.value.trim(), password.value);
      
      // Jika signUp tidak melempar error, beri tahu user (bisa jadi perlu verifikasi email)
      Get.snackbar('Sukses', 'Akun terdaftar. Silakan cek email untuk verifikasi (jika diperlukan).');
      // kembali ke login setelah beberapa saat atau segera:
      Get.offAllNamed('/login');
    } catch (e, st) {
      // tampilkan pesan error yang jelas & log stacktrace untuk debug
      debugPrint('Register error: $e\n$st');
      Get.snackbar('Registrasi gagal', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
