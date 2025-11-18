import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final LoginController c = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Email"),
            TextField(
              controller: c.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Masukkan email",
              ),
            ),

            const SizedBox(height: 16),

            const Text("Password"),
            TextField(
              controller: c.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Masukkan password",
              ),
            ),

            const SizedBox(height: 24),

            Obx(() {
              return ElevatedButton(
                onPressed: c.isLoading.value ? null : c.doLogin,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: c.isLoading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text("Login"),
              );
            }),

            const SizedBox(height: 8),

            Center(
              child: TextButton(
                onPressed: () => Get.toNamed('/register'),
                child: const Text("Belum punya akun? Daftar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
