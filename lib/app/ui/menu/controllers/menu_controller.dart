import 'package:get/get.dart';
import '../../../data/models/menu_model.dart';
import '../../../data/models/cart_item_model.dart';
import '../../../data/providers/menu_provider.dart';
import '../../../data/providers/cart_provider.dart';

class MenuPageController extends GetxController {
  final MenuProvider menuProvider = Get.find<MenuProvider>();
  final CartProvider cartProvider = Get.find<CartProvider>();

  final RxBool _isLoading = true.obs;
  final RxList<MenuModel> _menus = <MenuModel>[].obs;

  bool get isLoading => _isLoading.value;
  List<MenuModel> get menus => _menus;

  @override
  void onInit() {
    super.onInit();
    loadMenus();
  }

  Future<void> loadMenus() async {
    _isLoading.value = true;
    try {
      final result = await menuProvider.getMenus();
      _menus.assignAll(result);
    } finally {
      _isLoading.value = false;
    }
  }

  // ✅ METHOD YANG ERROR TADI
  void addToCart(MenuModel menu) {
    final item = CartItemModel(
      menuId: menu.id,           // STRING
      menuName: menu.name,
      imageUrl: menu.imageUrl,
      price: menu.price,
      qty: 1
    );

    cartProvider.addItem(item);
  }
}
