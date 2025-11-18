// lib/app/ui/menu/controllers/menu_controller.dart

import 'package:get/get.dart';
import 'package:demo_modul4/app/data/models/menu_model.dart';
import 'package:demo_modul4/app/data/models/cart_item_model.dart';
import 'package:demo_modul4/app/data/providers/menu_provider.dart';
import 'package:demo_modul4/app/data/providers/cart_provider.dart';

class MenuController extends GetxController {
  final MenuProvider _menuProvider = MenuProvider();
  late CartProvider cart; // aman karena diisi di onInit

  final menus = <MenuModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    cart = Get.find<CartProvider>(); // ambil instance yg sudah dibuat di main.dart
    fetchMenus();
  }

  Future<void> fetchMenus() async {
    isLoading.value = true;
    menus.value = await _menuProvider.getMenus();
    isLoading.value = false;
  }

  Future<void> addToCart(MenuModel menu) async {
    try {
      // Pastikan Hive box sudah terbuka
      await cart.init();

      final item = CartItemModel(
        menuId: menu.id,
        menuName: menu.name,
        quantity: 1,
        price: menu.price,
      );

      await cart.addToCart(item);

      Get.snackbar(
        'Berhasil',
        '${menu.name} ditambahkan ke keranjang',
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Gagal menambahkan: $e',
        duration: Duration(seconds: 3),
      );
    }
  }
}
