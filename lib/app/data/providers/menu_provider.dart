import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/menu_model.dart';

class MenuProvider {
  final supabase = Supabase.instance.client;

  Future<List<MenuModel>> getMenus() async {
    final data = await supabase.from('menu').select();

    return (data as List)
        .map((e) => MenuModel.fromJson(e))
        .toList();
  }
}
