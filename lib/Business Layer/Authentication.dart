import 'package:supabase_flutter/supabase_flutter.dart';
class Authentication {
  final SupabaseClient _client = Supabase.instance.client; //sets up connection for the database
// async method to add a user to the dataabse
  Future<User?> register({required String name, required String email,
    required String password,}) async {
    try {
      final response = await _client.auth.signUp(
        email: email.trim(),
        password: password,
        data: {'name': name.trim()},
      );
     // di b3mel refresh lel session b3d lama a  create user
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
  User? get currentUser => _client.auth.currentUser; // getter lel user le 3aml login
  // Get name from database
  String? get currentUserName => _client.auth.currentUser?.userMetadata?['name'] as String?;

  // Logout
  Future<void> logout() async {
    await _client.auth.signOut();
  }
}


