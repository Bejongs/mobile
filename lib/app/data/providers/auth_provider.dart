import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> signUp(String email, String password) async {
    try {
      // set timeout supaya tidak hang selamanya
      final future = _client.auth.signUp(email: email, password: password);
      await future.timeout(const Duration(seconds: 15));
      // note: signUp seringkali tidak membuat session (tergantung setting)
      // kita anggap jika tidak ada exception maka request dikirimkan.
    } on TimeoutException {
      throw Exception('Permintaan memakan waktu terlalu lama. Coba lagi.');
    } catch (e) {
      // lemparkan pesan error agar controller yang menampilkannya
      throw Exception(e.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password)
          .timeout(const Duration(seconds: 15));
      final user = _client.auth.currentUser;
      if (user == null) throw Exception('Login gagal: tidak ada sesi.');
    } on TimeoutException {
      throw Exception('Permintaan memakan waktu terlalu lama. Coba lagi.');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async => _client.auth.signOut();

  String? get currentUserId => _client.auth.currentUser?.id;
}
