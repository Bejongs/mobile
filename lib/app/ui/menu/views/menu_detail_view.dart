import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/menu_model.dart';
import '../controllers/menu_controller.dart';

class MenuDetailView extends GetView<MenuPageController> {
  const MenuDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final MenuModel menu = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(menu.name),
        backgroundColor: const Color(0xFFFF4B26),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                menu.imageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              menu.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(menu.description),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => controller.addToCart(menu),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4B26),
                ),
                child: const Text("Tambah ke Keranjang"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
