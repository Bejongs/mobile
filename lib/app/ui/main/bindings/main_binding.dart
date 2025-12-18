import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../../menu/bindings/menu_binding.dart';
import '../../profil/bindings/profil_binding.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());

    // 🔥 inject controller untuk tab
    MenuBinding().dependencies();
    ProfilBinding().dependencies();
  }
}
