import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/cart_provider.dart';
import '../../../data/models/cart_item_model.dart';

class CheckoutView extends StatelessWidget {
  final cartProvider = Get.find<CartProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),

      body: FutureBuilder(
        future: cartProvider.getAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final items = snapshot.data as List<CartItemModel>;

          if (items.isEmpty) {
            return Center(child: Text("Keranjang masih kosong"));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  title: Text(item.menuName),
                  subtitle: Text("Qty: ${item.quantity}"),
                  trailing: Text("Rp ${item.totalPrice}"),
                ),
              );
            },
          );
        },
      ),

      bottomNavigationBar: FutureBuilder(
        future: cartProvider.getAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return SizedBox();

          final items = snapshot.data as List<CartItemModel>;
          final total = items.fold<int>(0, (sum, item) => sum + item.totalPrice);

          return Container(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 55),
                shape: StadiumBorder(),
              ),
              onPressed: items.isEmpty
                  ? null
                  : () {
                      Get.snackbar("Pembayaran", "Berhasil membayar Rp $total");
                    },
              child: Text("Bayar · Rp $total"),
            ),
          );
        },
      ),
    );
  }
}
