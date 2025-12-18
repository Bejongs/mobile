import 'package:get/get.dart';
import '../models/cart_item_model.dart';

class CartProvider extends GetxController {
  final RxList<CartItemModel> items = <CartItemModel>[].obs;

  void addItem(CartItemModel item) {
    final index = items.indexWhere(
      (e) => e.menuId == item.menuId,
    );

    if (index >= 0) {
      items[index].qty++;
    } else {
      items.add(item);
    }
    items.refresh();
  }

  void increment(int index) {
    items[index].qty++;
    items.refresh();
  }

  void decrement(int index) {
    if (items[index].qty > 1) {
      items[index].qty--;
    } else {
      items.removeAt(index);
    }
    items.refresh();
  }

  int get totalItem =>
      items.fold(0, (sum, item) => sum + item.qty);

  int get totalPrice =>
      items.fold(0, (sum, item) => sum + item.total);

bool get isEmpty => items.isEmpty;

  void clear() {
    items.clear();
  }
}
