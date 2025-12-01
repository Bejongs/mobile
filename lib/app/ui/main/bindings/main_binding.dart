import 'package:get/get.dart';
import '../../menu/bindings/menu_binding.dart';
import '../../order/bindings/order_history_binding.dart';
import '../../profil/bindings/profil_binding.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    MenuBinding().dependencies();
    OrderHistoryBinding().dependencies();
    ProfilBinding().dependencies();
  }
}
