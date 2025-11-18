import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/keranjang_controller.dart';

class KeranjangView extends StatelessWidget {
  const KeranjangView({super.key});

  @override
  Widget build(BuildContext context) {
    final KeranjangController c = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: Obx(() {
        if (c.items.isEmpty) {
          return const Center(
            child: Text(
              'Keranjang masih kosong',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: c.items.length,
          itemBuilder: (_, i) {
            final item = c.items[i];

            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  item.menuName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Rp ${item.price}"),
                trailing: SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => c.decrement(item.menuId),
                      ),
                      Text(
                        item.quantity.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => c.increment(item.menuId),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => c.remove(item.menuId),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: const Border(top: BorderSide(color: Colors.grey)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: Rp ${c.totalPrice}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () => c.goToCheckout(),
                child: const Text("Checkout"),
              ),
            ],
          ),
        );
      }),
    );
  }
}
