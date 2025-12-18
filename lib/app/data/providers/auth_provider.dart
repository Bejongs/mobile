import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends GetxController {
  final _auth = Supabase.instance.client.auth;

  final RxString _userName = ''.obs;
  final RxString _userEmail = ''.obs;
  final RxString _userId = ''.obs;

  // ===== GETTER YANG DIPAKAI UI & CONTROLLER =====
  String get userName => _userName.value;
  String get userEmail => _userEmail.value;
  String get currentUserId => _userId.value;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  void loadUser() {
    final user = _auth.currentUser;
    if (user != null) {
      _userId.value = user.id;
      _userEmail.value = user.email ?? '';
      _userName.value =
          user.userMetadata?['name'] ??
          user.email?.split('@').first ??
          'User';
    }
  }

  // ===== LOGOUT UTAMA =====
  Future<void> logout() async {
    await _auth.signOut();
    await Hive.box('auth').clear();
    Get.offAllNamed('/login');
  }

  // ===== ALIAS AGAR TIDAK ERROR =====
  Future<void> signOut() async {
    await logout();
  }
}
