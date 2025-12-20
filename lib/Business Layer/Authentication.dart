import 'package:supabase_flutter/supabase_flutter.dart';
class Authentication {
  final SupabaseClient _client = Supabase.instance.client;

  Future<User?> register({required String name, required String email,
    required String password,}) async {
    try {
      final response = await _client.auth.signUp(
        email: email.trim(),
        password: password,
        data: {'name': name.trim()},
      );

      if (response.user != null) {
        await _client.auth.refreshSession();
      }

      return response.user;
    } catch (e) {
      print('Register error: $e');
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      return response.user;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }
  User? get currentUser => _client.auth.currentUser;

  // Get name from metadata
  String? get currentUserName => _client.auth.currentUser?.userMetadata?['name'] as String?;

  // Logout
  Future<void> logout() async {
    await _client.auth.signOut();
  }
}


