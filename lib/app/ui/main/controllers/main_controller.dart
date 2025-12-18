import 'package:get/get.dart';
import '../../menu/views/menu_view.dart';
import '../../order/views/order_history_view.dart';
import '../../profil/views/profil_view.dart';

class MainController extends GetxController {
  final index = 0.obs;

  final pages = [
    MenuView(),
    OrderHistoryView(), // ✅ RIWAYAT ADA DI SINI
    ProfilView(),
  ];

  void changeTab(int i) {
    index.value = i;
  }
}
