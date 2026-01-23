import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClient {
  static final SupabaseClient _instance = SupabaseClient._internal();
  factory SupabaseClient() => _instance;
  SupabaseClient._internal();

  static SupabaseClient get instance => _instance;
  static late final SupabaseClient client;
  static late final SupabaseClient supabase;

  static Future<void> initializeSupabase() async {
    await dotenv.load(fileName: ".env");
    
    final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
    final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
    
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      debug: kDebugMode,
    );
    
    client = SupabaseClient();
    supabase = SupabaseClient();
  }

  Future<User?> getCurrentUser() async {
    return Supabase.instance.client.auth.currentUser;
  }

  Future<AuthResponse> signIn(String email, String password) async {
    return await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp(String email, String password) async {
    return await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
  }
}

class SupabaseService {
  static final client = Supabase.instance.client;
}
