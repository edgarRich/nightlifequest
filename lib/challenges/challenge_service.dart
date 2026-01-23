import 'package:nightlifequest/challenges/challenge_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChallengeService {
  final supabase = Supabase.instance.client;
  
  Future<List<Challenge>> getUserChallenges(String userId) async {
    try {
      final response = await supabase
          .from('user_challenges')
          .select('*, challenge:challenges(*)')
          .eq('user_id', userId)
          .execute();
      
      if (response.error != null) throw response.error!;
      
      final List<Challenge> challenges = [];
      for (final item in response.data ?? []) {
        final challengeData = Map<String, dynamic>.from(item['challenge']);
        challenges.add(Challenge.fromJson({
          ...challengeData,
          'current_progress': item['current_progress'],
          'target_progress': challengeData['target_progress'] ?? 1,
        }));
      }
      
      return challenges;
    } catch (e) {
      throw Exception('Failed to fetch challenges: $e');
    }
  }
  
  Future<List<Challenge>> getActiveChallenges({String? venueId}) async {
    try {
      var query = supabase
          .from('challenges')
          .select('*')
          .eq('is_active', true)
          .gte('expires_at', DateTime.now().toIso8601String())
          .or('expires_at.is.null');
      
      if (venueId != null) {
        query = query.eq('venue_id', venueId);
      }
      
      final response = await query.execute();
      
      if (response.error != null) throw response.error!;
      
      return (response.data ?? [])
          .map((item) => Challenge.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch active challenges: $e');
    }
  }
  
  Future<void> updateChallengeProgress({
    required String userId,
    required String challengeId,
    required int progressIncrement,
  }) async {
    try {
      // Get current progress
      final currentResponse = await supabase
          .from('user_challenges')
          .select('current_progress')
          .eq('user_id', userId)
          .eq('challenge_id', challengeId)
          .single()
          .execute();
      
      if (currentResponse.error != null) throw currentResponse.error!;
      
      final currentProgress = currentResponse.data['current_progress'] ?? 0;
      
      // Update progress
      final updateResponse = await supabase
          .from('user_challenges')
          .update({'current_progress': currentProgress + progressIncrement})
          .eq('user_id', userId)
          .eq('challenge_id', challengeId)
          .execute();
      
      if (updateResponse.error != null) throw updateResponse.error!;
      
      // Check if challenge is completed and award points
      final challengeResponse = await supabase
          .from('challenges')
          .select('target_progress, points')
          .eq('id', challengeId)
          .single()
          .execute();
      
      if (challengeResponse.error != null) throw challengeResponse.error!;
      
      final targetProgress = challengeResponse.data['target_progress'] ?? 1;
      final points = challengeResponse.data['points'] ?? 0;
      
      if (currentProgress + progressIncrement >= targetProgress) {
        await awardPoints(userId, points, challengeId);
      }
    } catch (e) {
      throw Exception('Failed to update challenge progress: $e');
    }
  }
  
  Future<void> awardPoints(
    String userId,
    int points,
    String challengeId,
  ) async {
    try {
      // Update user points
      await supabase.rpc('increment_user_points', params: {
        'user_id': userId,
        'points': points,
      }).execute();
      
      // Record point transaction
      await supabase.from('point_transactions').insert({
        'user_id': userId,
        'challenge_id': challengeId,
        'points': points,
        'type': 'challenge_completion',
        'created_at': DateTime.now().toIso8601String(),
      }).execute();
    } catch (e) {
      throw Exception('Failed to award points: $e');
    }
  }
  
  Future<List<Challenge>> getDailyChallenges() async {
    try {
      final response = await supabase
          .from('challenges')
          .select('*')
          .eq('category', 'daily')
          .eq('is_active', true)
          .execute();
      
      if (response.error != null) throw response.error!;
      
      return (response.data ?? [])
          .map((item) => Challenge.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch daily challenges: $e');
    }
  }
  
  Future<List<Challenge>> getVenueChallenges(String venueId) async {
    try {
      final response = await supabase
          .from('challenges')
          .select('*')
          .eq('venue_id', venueId)
          .eq('is_active', true)
          .execute();
      
      if (response.error != null) throw response.error!;
      
      return (response.data ?? [])
          .map((item) => Challenge.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch venue challenges: $e');
    }
  }
}
