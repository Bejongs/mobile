import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_modul4/app/data/models/menu_model.dart';
import '../controllers/menu_controller.dart' as menu_ctrl;

class MenuDetailView extends StatelessWidget {
  final MenuModel menu;

  MenuDetailView({super.key, required this.menu});

  final menu_ctrl.MenuController c = Get.find<menu_ctrl.MenuController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),

      // =====================
      // TOMBOL TAMBAH FIXED
      // =====================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            )
          ],
        ),
        child: SizedBox(
          height: 55,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => c.addToCart(menu),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF4B26),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text("Tambah ke Keranjang"),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // =====================
            // HERO IMAGE BESAR
            // =====================
            Hero(
              tag: menu.imageUrl,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: Image.network(
                  menu.imageUrl,
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 280,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 60),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =====================
            // KONTEN DETAIL
            // =====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NAMA MAKANAN
                  Text(
                    menu.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // HARGA
                  Text(
                    "Rp ${menu.price}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF4B26),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF333333),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // DESKRIPSI DETAIL
                  Text(
                    menu.description,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Color(0xFF555555),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // OPSIONAL: info tambahan
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.timer, color: Colors.orange),
                        SizedBox(width: 10),
                        Text(
                          "Estimasi siap dalam 10–15 menit",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF444444),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
