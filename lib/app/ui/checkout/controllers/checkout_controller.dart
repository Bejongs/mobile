import 'package:get/get.dart';
import 'package:demo_modul4/app/data/providers/cart_provider.dart';
import 'package:demo_modul4/app/data/providers/order_provider.dart';
import 'package:demo_modul4/app/data/models/cart_item_model.dart';

class CheckoutController extends GetxController {
  final CartProvider cartProvider = Get.find<CartProvider>();
  final OrderProvider orderProvider = Get.find<OrderProvider>();

  RxList<CartItemModel> items = <CartItemModel>[].obs;
  RxInt total = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  /// Ambil isi keranjang dari Hive
  Future<void> loadCart() async {
    final data = await cartProvider.getAll();
    items.value = data;
    total.value = data.fold(0, (sum, item) => sum + item.totalPrice);
  }

  /// Proses checkout → simpan Supabase → kosongkan keranjang → tampilkan dialog
  Future<void> doCheckout() async {
    if (items.isEmpty) {
      Get.snackbar("Gagal", "Keranjang masih kosong");
      return;
    }

    try {
      // Buat payload untuk Supabase
      final payload = items
          .map((e) => {
                'menu_id': e.menuId,
                'menu_name': e.menuName,
                'quantity': e.quantity,
                'price': e.price,
              })
          .toList();

      // Kirim ke Supabase
      await orderProvider.createOrder(
        userId: "guest", // kalau belum ada auth
        total: total.value,
        items: payload,
      );

      // Kosongkan keranjang
      await cartProvider.clear();

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Pesanan berhasil dibuat!",
        textConfirm: "OK",
        onConfirm: () {
          Get.back(); // tutup dialog
          Get.back(); // kembali ke Menu
        },
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Gagal",
        middleText: "Pesanan gagal: $e",
      );
    }
  }
}
