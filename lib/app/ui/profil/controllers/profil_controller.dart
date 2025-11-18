import 'package:get/get.dart';
import '../../../data/providers/order_provider.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../data/models/order_model.dart';

class ProfilController extends GetxController {
  final OrderProvider _orderProvider = OrderProvider();
  final AuthProvider _auth = AuthProvider();

  final orders = <OrderModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  Future<void> loadOrders() async {
    final userId = _auth.currentUserId;
    if (userId == null) return;
    try {
      isLoading.value = true;
      final list = await _orderProvider.getOrdersByUser(userId);
      orders.assignAll(list);
    } catch (e) {
      Get.snackbar('Gagal', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }
}
