class AppConstants {
  // API Endpoints
  static const String supabaseUrl = 'https://your-project.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key';
  
  // Point values from website
  static const int checkInPoints = 10;
  static const int eatDrinkPoints = 15;
  static const int songRequestPoints = 10;
  static const int socializePoints = 20;
  
  // Level thresholds
  static const List<int> levelThresholds = [
    0,      // Level 1
    100,    // Level 2
    250,    // Level 3
    500,    // Level 4
    1000,   // Level 5
    2000,   // VIP Level
  ];
  
  // Badge IDs
  static const String badgeNightOwl = 'night_owl';
  static const String badgeSocialButterfly = 'social_butterfly';
  static const String badgeVibeMaster = 'vibe_master';
  static const String badgeClubKing = 'club_king';
  static const String badgePartyPro = 'party_pro';
  static const String badgeVIP = 'vip';
  
  // Collection names
  static const String usersCollection = 'users';
  static const String clubsCollection = 'clubs';
  static const String checkinsCollection = 'checkins';
  static const String challengesCollection = 'challenges';
  static const String rewardsCollection = 'rewards';
  
  // Storage buckets
  static const String clubImagesBucket = 'club-images';
  static const String userAvatarsBucket = 'user-avatars';
  
  // Default values
  static const int defaultRadiusKm = 10;
  static const int maxCheckinsPerDay = 5;
}
