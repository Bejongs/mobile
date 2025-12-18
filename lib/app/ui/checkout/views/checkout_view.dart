import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/providers/cart_provider.dart';
import '../../../widgets/cart_item_card.dart';
import '../../../core/notification/notification_service.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: const Color(0xFFFF4B26),
      ),
      body: Obx(() {
        if (cart.items.isEmpty) {
          return const Center(
            child: Text("Keranjang kosong"),
          );
        }

        return Column(
          children: [
            // 🛒 LIST ITEM
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return CartItemCard(item: item);
                },
              ),
            ),

            // 💰 TOTAL & BAYAR
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: Rp ${cart.totalPrice}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF4B26),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () async {
                      // 🔔 NOTIFIKASI + SUARA
                      
                      // 🧹 CLEAR CART
                      cart.clear();

                      // 🔙 KEMBALI KE MAIN
                      Get.offAllNamed('/main');

                      // 📢 FEEDBACK UI
                      Get.snackbar(
                        "Berhasil",
                        "Pesanan berhasil dibuat",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: const Text(
                      "Bayar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
