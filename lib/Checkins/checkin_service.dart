import 'package:nightlifequest/core/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CheckinService {
  final supabase = Supabase.instance.client;
  
  Future<Map<String, dynamic>> processCheckin({
    required String qrData,
    required String userId,
  }) async {
    try {
      // Parse QR data (assuming format: venue:venue-id)
      final parts = qrData.split(':');
      if (parts.length != 2 || parts[0] != 'venue') {
        throw Exception('Invalid QR code format');
      }
      
      final venueId = parts[1];
      
      // Check if user has already checked in today
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      
      final checkinsResponse = await supabase
          .from('checkins')
          .select('id')
          .eq('user_id', userId)
          .eq('venue_id', venueId)
          .gte('created_at', todayStart.toIso8601String())
          .execute();
      
      if (checkinsResponse.error != null) throw checkinsResponse.error!;
      
      if ((checkinsResponse.data ?? []).isNotEmpty) {
        throw Exception('Already checked in today');
      }
      
      // Get venue details
      final venueResponse = await supabase
          .from('clubs')
          .select('name, checkin_points')
          .eq('id', venueId)
          .single()
          .execute();
      
      if (venueResponse.error != null) throw venueResponse.error!;
      
      final venueName = venueResponse.data['name'];
      final checkinPoints = venueResponse.data['checkin_points'] ?? AppConstants.checkInPoints;
      
      // Record check-in
      final checkinResponse = await supabase
          .from('checkins')
          .insert({
            'user_id': userId,
            'venue_id': venueId,
            'points_awarded': checkinPoints,
            'created_at': now.toIso8601String(),
          })
          .execute();
      
      if (checkinResponse.error != null) throw checkinResponse.error!;
      
      // Award points
      await supabase.rpc('increment_user_points', params: {
        'user_id': userId,
        'points': checkinPoints,
      }).execute();
      
      // Record point transaction
      await supabase.from('point_transactions').insert({
        'user_id': userId,
        'venue_id': venueId,
        'points': checkinPoints,
        'type': 'checkin',
        'created_at': now.toIso8601String(),
      }).execute();
      
      // Get challenges unlocked by this check-in
      final challengesResponse = await supabase
          .from('challenges')
          .select('id')
          .eq('venue_id', venueId)
          .eq('is_active', true)
          .eq('trigger_type', 'checkin')
          .execute();
      
      final challengesUnlocked = (challengesResponse.data ?? []).length;
      
      return {
        'success': true,
        'venueName': venueName,
        'pointsAwarded': checkinPoints,
        'challengesUnlocked': challengesUnlocked,
      };
    } catch (e) {
      throw Exception('Failed to process check-in: $e');
    }
  }
  
  Future<List<Map<String, dynamic>>> getUserCheckins(String userId) async {
    try {
      final response = await supabase
          .from('checkins')
          .select('*, venue:clubs(name, image_url)')
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .execute();
      
      if (response.error != null) throw response.error!;
      
      return List<Map<String, dynamic>>.from(response.data ?? []);
    } catch (e) {
      throw Exception('Failed to fetch user check-ins: $e');
    }
  }
  
  Future<List<Map<String, dynamic>>> getRecentCheckins({
    String? venueId,
    int limit = 20,
  }) async {
    try {
      var query = supabase
          .from('checkins')
          .select('*, user:users(username), venue:clubs(name)')
          .order('created_at', ascending: false)
          .limit(limit);
      
      if (venueId != null) {
        query = query.eq('venue_id', venueId);
      }
      
      final response = await query.execute();
      
      if (response.error != null) throw response.error!;
      
      return List<Map<String, dynamic>>.from(response.data ?? []);
    } catch (e) {
      throw Exception('Failed to fetch recent check-ins: $e');
    }
  }
  
  Future<bool> canUserCheckin(String userId, String venueId) async {
    try {
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      
      final response = await supabase
          .from('checkins')
          .select('id')
          .eq('user_id', userId)
          .eq('venue_id', venueId)
          .gte('created_at', todayStart.toIso8601String())
          .execute();
      
      if (response.error != null) throw response.error!;
      
      return (response.data ?? []).isEmpty;
    } catch (e) {
      throw Exception('Failed to check check-in eligibility: $e');
    }
  }
}
