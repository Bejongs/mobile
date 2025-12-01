import 'package:get/get.dart';
import '../../../data/providers/order_provider.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../data/models/order_model.dart';

class OrderHistoryController extends GetxController {
  final OrderProvider _orderProvider = OrderProvider();
  final AuthProvider _auth = AuthProvider();

  var orders = <OrderModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  Future<void> loadOrders() async {
    final userId = _auth.currentUserId;
    if (userId == null) return;

    try {
      isLoading(true);
      final data = await _orderProvider.getOrdersByUser(userId);
      orders.assignAll(data);
    } finally {
      isLoading(false);
    }
  }
}
