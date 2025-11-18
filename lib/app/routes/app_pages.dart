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
      name: Routes.ADMIN_MENU,
      page: () => AdminMenuView(),
      binding: AdminMenuBinding(),
      middlewares: [AuthMiddleware()],
    ),

    // notes
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
      name: Routes.KERANJANG,
      page: () => KeranjangView(),
      binding: KeranjangBinding(),
      middlewares: [AuthMiddleware()],
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
  ];
}
