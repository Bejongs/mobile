import 'package:get/get.dart';
import 'package:demo_modul4/app/data/providers/cart_provider.dart';
import '../controllers/menu_controller.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartProvider>(() => CartProvider());
    Get.lazyPut<MenuController>(() => MenuController());
  }
}

