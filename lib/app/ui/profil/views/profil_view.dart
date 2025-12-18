import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../data/providers/auth_provider.dart';

class ProfilView extends StatelessWidget {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthProvider>();
    final theme = Get.find<ThemeController>();

    return Scaffold(
      body: Column(
        children: [
          // HEADER MERAH
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 48, bottom: 32),
            decoration: const BoxDecoration(
              color: Color(0xFFB3261E),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // CARD PROFIL
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(() => Column(
                      children: [
                        Text(
                          auth.userName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          auth.userEmail,
                          style: TextStyle(color: Colors.grey[600]),
                        ),

                        const Divider(height: 32),

                        // DARK MODE
                        Row(
                          children: [
                            const Icon(Icons.dark_mode),
                            const SizedBox(width: 12),
                            const Expanded(child: Text("Dark Mode")),
                            Switch(
                              value: theme.isDark.value,
                              onChanged: (_) => theme.toggleTheme(),
                            ),
                          ],
                        ),

                        const Divider(height: 32),

                        // LOGOUT
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.logout),
                          title: const Text("Log Out"),
                          onTap: auth.logout,
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
