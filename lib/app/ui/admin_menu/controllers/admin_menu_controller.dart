import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/models/menu_model.dart';

class AdminMenuController extends GetxController {
  final SupabaseClient _client = Supabase.instance.client;

  final menus = <MenuModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMenus();
  }

  Future<void> loadMenus() async {
    try {
      isLoading.value = true;

      final res = await _client
          .from('menu')
          .select()
          .order('name', ascending: true);

      menus.value = (res as List)
          .map((e) => MenuModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

    } catch (e) {
      Get.snackbar("Error", "Gagal memuat menu");
    } finally {
      isLoading.value = false;
    }
  }

  /// ------------------------------
  /// SAVE (tambah atau update)
  /// ------------------------------
  Future<bool> saveMenu({
    required String name,
    required int price,
    required String description,
    String? id,  // jika null → tambah, jika ada → update
  }) async {
    try {
      if (id == null) {
        // INSERT data baru
        await _client.from('menu').insert({
          'name': name,
          'price': price,
          'description': description,
        });
      } else {
        // UPDATE data lama
        await _client.from('menu').update({
          'name': name,
          'price': price,
          'description': description,
        }).eq('id', id);
      }

      await loadMenus(); // refresh data
      return true;

    } catch (e) {
      Get.snackbar("Error", "Gagal menyimpan menu");
      return false;
    }
  }

  /// ------------------------------
  /// DELETE menu
  /// ------------------------------
  Future<bool> deleteMenu(String id) async {
    try {
      await _client.from('menu').delete().eq('id', id);
      await loadMenus();
      return true;

    } catch (e) {
      Get.snackbar("Gagal", "Gagal menghapus menu");
      return false;
    }
  }
}
