import 'package:get/get.dart';
import '../controllers/order_history_controller.dart';

class OrderHistoryBinding extends Bindings {
  @override
  void dependencies() {
    // 🔑 INI WAJIB

    Get.lazyPut<OrderHistoryController>(
      () => OrderHistoryController(),
    );
  }
}
