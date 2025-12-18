import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';
import 'app/core/theme/theme_controller.dart';
import 'app/data/providers/cart_provider.dart';
import 'app/data/providers/menu_provider.dart';
import 'app/data/providers/order_provider.dart';
import 'app/data/providers/auth_provider.dart';
import 'app/data/models/cart_item_model.dart';
import 'app/core/lifecycle/lifecycle_event_handler.dart';
import 'app/core/notification/notification_service.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
          title: "Demo Modul 4",
          theme: themeController.currentTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
        ));
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1️⃣ INIT HIVE
  await Hive.initFlutter();

  // 2️⃣ REGISTER ADAPTER


  // 3️⃣ OPEN BOX
  await Hive.openBox<CartItemModel>('cart');
  await Hive.openBox('auth');

  // 4️⃣ LOAD ENV
  await dotenv.load(fileName: ".env");

  // 5️⃣ INIT SUPABASE
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  await NotificationHandler.instance.init();


  // 6️⃣ APP LIFECYCLE
  WidgetsBinding.instance.addObserver(
    LifecycleEventHandler(
      inactiveCallBack: () async {},
      detachedCallBack: () async {},
    ),
  );

  // 7️⃣ INIT PROVIDERS (PUT SEKALI SAJA)
  Get.put<CartProvider>(CartProvider(), permanent: true);
  Get.put<MenuProvider>(MenuProvider(), permanent: true);
  Get.put<OrderProvider>(OrderProvider(), permanent: true);
  Get.put<AuthProvider>(AuthProvider(), permanent: true);

  // 8️⃣ INIT THEME
  await Get.put(ThemeController()).loadTheme();

  // 9️⃣ RUN APP
  runApp(const MyApp());
}
