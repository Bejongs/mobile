import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_menu_controller.dart';
import 'package:demo_modul4/app/ui/login/controllers/login_controller.dart';


class AdminMenuView extends GetView<AdminMenuController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin – Kelola Menu"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              final loginC = Get.find<LoginController>();
              loginC.logout();
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.snackbar("Info", "Form tambah menu belum dibikin ya 😄");
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.menus.isEmpty) {
          return const Center(child: Text("Belum ada menu"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.menus.length,
          itemBuilder: (_, i) {
            final m = controller.menus[i];
            return Card(
              child: ListTile(
                title: Text(m.name),
                subtitle: Text("Rp ${m.price}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    controller.deleteMenu(m.id);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
