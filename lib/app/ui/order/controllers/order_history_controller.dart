import 'package:get/get.dart';
import '../../../data/providers/cart_provider.dart';
import '../../../data/models/cart_item_model.dart';

class OrderHistoryController extends GetxController {
  final CartProvider cart = Get.find<CartProvider>();

  List<CartItemModel> get orders => cart.items;

  void buyAgain(CartItemModel item) {
    cart.addItem(item);
  }
}
