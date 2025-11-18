import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/theme_controller.dart';

class ProfilView extends StatelessWidget {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController tC = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: tC.isDark.value,
                  onChanged: (_) => tC.toggleTheme(),
                )),
            // other profile items...
          ],
        ),
      ),
    );
  }
}
