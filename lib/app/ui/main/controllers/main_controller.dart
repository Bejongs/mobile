import 'package:get/get.dart';
import '../../menu/views/menu_view.dart';
import '../../order/views/order_history_view.dart';
import '../../profil/views/profil_view.dart';

class MainController extends GetxController {
  // Index tab yang aktif
  var index = 0.obs;

  // Halaman yang akan ditampilkan pada body
  final pages = const [
    MenuView(),
    OrderHistoryView(),
    ProfilView(),
  ];

  // Mengubah tab
  void changeTab(int i) {
    index.value = i;
  }
}
