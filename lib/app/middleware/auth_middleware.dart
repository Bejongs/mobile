import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:demo_modul4/app/core/constants/admin_emails.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      return const RouteSettings(name: Routes.LOGIN);
    }

    final email = user.email ?? "";

    // CEK ROLE ADMIN
    final isAdmin = adminEmails.contains(email);

    if (isAdmin && route != Routes.ADMIN_MENU) {
      return const RouteSettings(name: Routes.ADMIN_MENU);
    }

    if (!isAdmin && route == Routes.ADMIN_MENU) {
      return const RouteSettings(name: Routes.MENU);
    }

    return null;
  }
}
