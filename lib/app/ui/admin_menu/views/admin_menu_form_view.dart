import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_modul4/app/data/models/menu_model.dart';
import '../controllers/admin_menu_controller.dart';

class AdminMenuFormView extends StatelessWidget {
  final MenuModel? menu;

  AdminMenuFormView({super.key, this.menu});

  final c = Get.find<AdminMenuController>();

  @override
  Widget build(BuildContext context) {
    final nameCtrl = TextEditingController(text: menu?.name ?? "");
    final priceCtrl = TextEditingController(text: menu?.price.toString() ?? "");
    final descCtrl = TextEditingController(text: menu?.description ?? "");

    return Scaffold(
      appBar: AppBar(title: Text(menu == null ? "Tambah Menu" : "Edit Menu")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Nama")),
            TextField(controller: priceCtrl, decoration: const InputDecoration(labelText: "Harga"), keyboardType: TextInputType.number),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: "Deskripsi")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await c.saveMenu(
                  name: nameCtrl.text,
                  price: int.tryParse(priceCtrl.text) ?? 0,
                  description: descCtrl.text,
                  id: menu?.id,
                );
                Get.back(result: true);
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
