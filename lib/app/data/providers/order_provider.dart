// lib/app/data/providers/order_provider.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/order_model.dart';

class OrderProvider {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> createOrder({
    required String userId,
    required int total,
    required List<Map<String, dynamic>> items,
  }) async {
    final response = await _client.from('orders').insert({
      'user_id': userId,
      'total': total,
      'items': items,
    });

    if (response == null) {
      throw Exception('Gagal membuat order');
    }
  }

  // ✅ TAMBAHKAN METHOD INI
  Future<List<OrderModel>> getOrdersByUser(String userId) async {
    final res = await _client
        .from('orders')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (res as List)
        .map((e) => OrderModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
