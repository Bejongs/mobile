import 'package:get/get.dart';
import 'package:demo_modul4/app/data/providers/cart_provider.dart';
import '../controllers/keranjang_controller.dart';

class KeranjangBinding extends Bindings {
  @override
  void dependencies() {

    // Jangan buat instance baru — cukup gunakan instance yang sudah didaftarkan
    if (!Get.isRegistered<CartProvider>()) {
      Get.putAsync<CartProvider>(() async {
        final provider = CartProvider();
        await provider.init();
        return provider;
      });
    }

    Get.lazyPut<KeranjangController>(() => KeranjangController());
  }
}
