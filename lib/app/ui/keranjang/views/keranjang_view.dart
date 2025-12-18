import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/cart_provider.dart';

class KeranjangView extends StatelessWidget {
  const KeranjangView({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: Obx(() {
        if (cart.items.isEmpty) {
          return const Center(child: Text('Keranjang kosong'));
        }

        return ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, index) {
            final item = cart.items[index];

            return ListTile(
              title: Text(item.menuName),
              subtitle: Text(
                'Rp ${item.price} x ${item.qty} = Rp ${item.total}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => cart.decrement(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => cart.increment(index),
                  ),
                ],
              ),
            );
          },
        );
      }),

      // ✅ TOMBOL CHECKOUT
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: cart.isEmpty
                ? null
                : () {
                    Get.toNamed('/checkout');
                  },
            child: Text(
              cart.isEmpty
                  ? 'Keranjang Kosong'
                  : 'Checkout • Rp ${cart.totalPrice}',
            ),
          ),
        );
      }),
    );
  }
}
