import 'package:get/get.dart';
import 'app_routes.dart';

// LOGIN
import '../ui/login/views/login_view.dart';
import '../ui/login/bindings/login_binding.dart';

// REGISTER
import '../ui/register/views/register_view.dart';
import '../ui/register/bindings/register_binding.dart';

// MENU
import '../ui/menu/views/menu_view.dart';
import '../ui/menu/views/menu_detail_view.dart';
import '../ui/menu/bindings/menu_binding.dart';

// KERANJANG
import '../ui/keranjang/views/keranjang_view.dart';
import '../ui/keranjang/bindings/keranjang_binding.dart';

// CHECKOUT
import '../ui/checkout/views/checkout_view.dart';
import '../ui/checkout/bindings/checkout_binding.dart';

// PROFIL
import '../ui/profil/views/profil_view.dart';
import '../ui/profil/bindings/profil_binding.dart';

import '../ui/notes/views/note_view.dart';
import '../ui/notes/bindings/notes_binding.dart';
import '../ui/notes/views/note_edit_view.dart';

import '../ui/splash/views/splash_view.dart';
import '../ui/splash/bindings/splash_binding.dart';

import '../ui/admin_menu/bindings/admin_menu_binding.dart';
import '../ui/admin_menu/views/admin_menu_view.dart';

import '../middleware/auth_middleware.dart';

import '../ui/main/views/main_view.dart';
import '../ui/main/bindings/main_binding.dart';

import '../ui/api_test/bindings/api_test_bindings.dart';
import '../ui/api_test/views/api_test_view.dart';

import '../ui/location/views/location_home_view.dart';
import '../ui/location/bindings/location_binding.dart';

import '../ui/order/bindings/order_history_binding.dart';
import '../ui/order/views/order_history_view.dart';


class AppPages {
  AppPages._();

  static const initial = Routes.SPLASH;

  static final routes = <GetPage>[
    GetPage(
      name: '/',
      page: () => SplashView(),
      bindings: [
        SplashBinding(),
        LoginBinding(), // ⬅️ TAMBAHKAN INI
      ],
    ),

    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),

    GetPage(
      name: Routes.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),

    GetPage(
      name: Routes.ADMIN_MENU,
      page: () => AdminMenuView(),
      binding: AdminMenuBinding(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/notes',
      page: () => NotesView(),
      binding: NotesBinding(),
    ),

    GetPage(
      name: '/notes/edit',
      page: () => NoteEditView(),
      binding: NotesBinding(),
    ),

    GetPage(
      name: Routes.MENU,
      page: () => MenuView(),
      binding: MenuBinding(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/menu-detail',
      page: () => MenuDetailView(),
      binding: MenuBinding(),
    ),

    GetPage(
      name: Routes.KERANJANG,
      page: () => KeranjangView(),
      binding: KeranjangBinding(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.ORDER_HISTORY,
      page: () => OrderHistoryView(),
      binding: OrderHistoryBinding(),
    ),

    GetPage(
      name: Routes.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
      middlewares: [AuthMiddleware()],
    ),
    
    GetPage(
      name: Routes.PROFIL,
      page: () => ProfilView(),
      binding: ProfilBinding(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.API_TEST,
      page: () => ApiTestView(),
      binding: ApiTestBinding(),
    ),

    GetPage(
      name: Routes.LOCATION,
      page: () => const LocationHomeView(),
      binding: LocationBinding(),
    ),

  ];
}
