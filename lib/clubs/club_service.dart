import 'package:nightlifequest/core/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClubService {
  final SupabaseClient _supabase = SupabaseClient();
  
  Future<List<Map<String, dynamic>>> getNearbyClubs(
    double latitude,
    double longitude,
    double radiusKm,
  ) async {
    try {
      final response = await Supabase.instance.client
          .from('clubs')
          .select('*')
          .execute();
      
      if (response.error != null) throw response.error!;
      
      final clubs = List<Map<String, dynamic>>.from(response.data ?? []);
      
      // Filter clubs within radius (simplified - implement actual haversine)
      return clubs;
    } catch (e) {
      throw Exception('Failed to fetch clubs: $e');
    }
  }
  
  Future<Map<String, dynamic>> getClubDetails(String clubId) async {
    try {
      final response = await Supabase.instance.client
          .from('clubs')
          .select('*, events(*)')
          .eq('id', clubId)
          .single()
          .execute();
      
      if (response.error != null) throw response.error!;
      
      return Map<String, dynamic>.from(response.data);
    } catch (e) {
      throw Exception('Failed to fetch club details: $e');
    }
  }
  
  Future<List<Map<String, dynamic>>> getClubEvents(String clubId) async {
    try {
      final response = await Supabase.instance.client
          .from('events')
          .select('*')
          .eq('club_id', clubId)
          .gte('date', DateTime.now().toIso8601String())
          .order('date')
          .execute();
      
      if (response.error != null) throw response.error!;
      
      return List<Map<String, dynamic>>.from(response.data ?? []);
    } catch (e) {
      throw Exception('Failed to fetch events: $e');
    }
  }
  
  Future<String> getClubImageUrl(String clubId, String imageName) async {
    return Supabase.instance.client.storage
        .from('club-images')
        .getPublicUrl('$clubId/$imageName');
  }
}
