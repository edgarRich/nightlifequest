// auth_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {
  // Use the globally initialized client
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> signIn(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.error != null) {
        throw Exception(response.error!.message);
      }
    } on Exception catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      if (response.error != null) {
        throw Exception(response.error!.message);
      }
    } on Exception catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<void> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
    );
    // Note: This triggers a browser redirect; handle deep links / universal links for mobile
  }

  Future<void> signOut() async {
    try {
      final response = await _client.auth.signOut();
      if (response.error != null) {
        throw Exception(response.error!.message);
      }
    } on Exception catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  Future<User?> getCurrentUser() async {
    return _client.auth.currentUser;
  }

  Stream<bool> get authStateChanges {
    // Convert Supabase's GoTrue subscription to a bool stream
    return _client.auth.onAuthStateChange.map((event) {
      return event.session != null;
    });
  }
}
