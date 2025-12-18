import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/cart_provider.dart';
import '../controllers/menu_controller.dart';

class MenuView extends GetView<MenuPageController> {
  MenuView({super.key});

  final cart = Get.find<CartProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade700,
      body: SafeArea(
        child: Column(
          children: [
            // SEARCH + CART (SEARCH DUMMY)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: "Cari menu",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () => Get.toNamed('/keranjang'),
                    child: Stack(
                      children: [
                        const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 28,
                        ),
                        Positioned(
                          right: 0,
                          child: Obx(() {
                            if (cart.totalItem == 0) {
                              return const SizedBox();
                            }
                            return Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${cart.totalItem}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Obx(() {
                  if (controller.isLoading) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }

                  return GridView.builder(
                    itemCount: controller.menus.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final menu = controller.menus[index];

                      return InkWell(
                        onTap: () => Get.toNamed(
                          '/menu-detail',
                          arguments: menu,
                        ),
                        child: Card(
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(
                                  menu.imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  menu.name,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    controller.addToCart(menu),
                                child: const Text("Tambah"),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
