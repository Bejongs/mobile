// lib/app/data/providers/menu_provider.dart
import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/menu_model.dart';

class MenuProvider {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<MenuModel>> getMenus() async {
  try {
    final res = await Supabase.instance.client
        .from('menu')
        .select()
        .order('name', ascending: true)
        .timeout(const Duration(seconds: 15));

    if (res == null) return [];

    // Supabase returns a List of maps
    return (res as List).map((e) => MenuModel.fromJson(Map<String, dynamic>.from(e))).toList();
  } on TimeoutException catch (_) {
    debugPrint('getMenus: timeout');
    return [];
  } on SocketException catch (e) {
    debugPrint('getMenus: socket exception -> $e');
    return [];
  } catch (e, st) {
    debugPrint('getMenus error: $e\n$st');
    return [];
  }
}

Future<bool> createMenu(MenuModel menu) async {
  try {
    await _client.from('menu').insert({
      'name': menu.name,
      'description': menu.description,
      'price': menu.price,
      'image_url': menu.imageUrl,
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updateMenu(MenuModel menu) async {
  try {
    await _client.from('menu').update({
      'name': menu.name,
      'description': menu.description,
      'price': menu.price,
      'image_url': menu.imageUrl,
    }).eq('id', menu.id);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> deleteMenu(String id) async {
  try {
    await _client.from('menu').delete().eq('id', id);
    return true;
  } catch (e) {
    return false;
  }
}

  // jika butuh CRUD lain: createMenu, updateMenu, deleteMenu
}
