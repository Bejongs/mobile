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


class MyApp extends StatelessWidget {
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

  print("STEP 1: HIVE INIT");
  await Hive.initFlutter();

  print("STEP 1.5: REGISTER ADAPTER");
  Hive.registerAdapter(CartItemModelAdapter());

  print("STEP 2: OPEN BOX");
  await Hive.openBox<CartItemModel>('cart');

  print("STEP 3: LOAD ENV");
  await dotenv.load(fileName: ".env");

  print("STEP 4: INIT SUPABASE");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  WidgetsBinding.instance.addObserver(
  LifecycleEventHandler(
    detachedCallBack: () async {
      await Supabase.instance.client.auth.signOut();
    },
    inactiveCallBack: () async {
      await Supabase.instance.client.auth.signOut();
    },
  ),
);


  print("STEP 5: INIT PROVIDERS");
  await Get.put(CartProvider()).init();
  Get.put(MenuProvider());
  Get.put(OrderProvider());
  Get.put(AuthProvider());

  print("STEP 6: INIT THEME");
  await Get.put(ThemeController()).loadTheme();

  final cart = Get.put(CartProvider());
  await cart.init();

  print("STEP 7: RUNAPP");
  runApp(MyApp());
}
