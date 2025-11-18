import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:demo_modul4/app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    Future.delayed(const Duration(seconds: 1), () {
      final session = Supabase.instance.client.auth.currentSession;

      // BELUM LOGIN → HALAMAN LOGIN
      if (session == null) {
        Get.offAllNamed(Routes.LOGIN);
        return;
      }

      // SUDAH LOGIN → CEK EMAIL
      final email = session.user.email;
      const adminEmails = [
        "hedypratama@gmail.com",
        "admin@gmail.com",
      ];

      if (adminEmails.contains(email)) {
        Get.offAllNamed('/admin/menu');
      } else {
        Get.offAllNamed(Routes.MENU);
      }
    });
  }
}
