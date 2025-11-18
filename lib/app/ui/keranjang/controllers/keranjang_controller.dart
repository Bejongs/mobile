// lib/app/ui/keranjang/controllers/keranjang_controller.dart
import 'package:get/get.dart';
import 'package:demo_modul4/app/data/providers/cart_provider.dart';
import 'package:demo_modul4/app/data/models/cart_item_model.dart';

class KeranjangController extends GetxController {
  final CartProvider _cartProvider = Get.find<CartProvider>();

  final items = <CartItemModel>[].obs;

  Future<void> loadItems() async {
  final list = await _cartProvider.getAll();
  items.assignAll(list);
}

@override
void onInit() {
  super.onInit();
  Future.microtask(() => loadItems());
}

  // menambah qty item (mis. dari UI: + button)
  Future<void> increment(String menuId) async {
    final it = items.firstWhereOrNull((e) => e.menuId == menuId);
    if (it != null) {
      it.quantity = it.quantity + 1;
      await _cartProvider.updateItem(it);
      loadItems();
    }
  }

  // mengurangi qty item (mis. dari UI: - button)
  Future<void> decrement(String menuId) async {
    await _cartProvider.decrementItem(menuId);
    loadItems();
  }

  // hapus item
  Future<void> remove(String menuId) async {
    await _cartProvider.removeItem(menuId);
    loadItems();
  }

  // langsung set jumlah baru (mis. user input)
  Future<void> setQuantity(String menuId, int qty) async {
    final it = items.firstWhereOrNull((e) => e.menuId == menuId);
    if (it != null) {
      it.quantity = qty;
      await _cartProvider.updateItem(it);
      loadItems();
    }
  }

  void goToCheckout() {
  if (items.isEmpty) {
    Get.snackbar('Info', 'Keranjang kosong');
    return;
  }
  // gunakan route string '/checkout' supaya tidak tergantung nama konstanta
  Get.toNamed('/checkout');
}

  int get totalPrice {
    return items.fold(0, (prev, e) => prev + e.totalPrice);
  }
}
