await SupabaseService.client.from('checkins').insert({
  'club_id': clubId,
  'challenge_id': challengeId,
});
