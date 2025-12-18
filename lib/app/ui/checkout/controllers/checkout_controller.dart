import 'package:get/get.dart';
import '../../../data/providers/cart_provider.dart';

class CheckoutController extends GetxController {
  final cart = Get.find<CartProvider>();

  int get totalPrice => cart.totalPrice;

  void submitOrder() {
    cart.clear(); // JANGAN await
  }
}
