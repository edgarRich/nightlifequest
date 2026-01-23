class Challenge {
  final String id;
  final String title;
  final String description;
  final int points;
  final String category;
  final String icon;
  final bool isActive;
  final DateTime? expiresAt;
  final Map<String, dynamic>? requirements;
  final int currentProgress;
  final int targetProgress;
  final String? venueId;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.category,
    required this.icon,
    this.isActive = true,
    this.expiresAt,
    this.requirements,
    this.currentProgress = 0,
    this.targetProgress = 1,
    this.venueId,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      points: json['points'],
      category: json['category'],
      icon: json['icon'] ?? '🎯',
      isActive: json['is_active'] ?? true,
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'])
          : null,
      requirements: json['requirements'],
      currentProgress: json['current_progress'] ?? 0,
      targetProgress: json['target_progress'] ?? 1,
      venueId: json['venue_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'points': points,
      'category': category,
      'icon': icon,
      'is_active': isActive,
      'expires_at': expiresAt?.toIso8601String(),
      'requirements': requirements,
      'current_progress': currentProgress,
      'target_progress': targetProgress,
      'venue_id': venueId,
    };
  }

  double get progressPercentage {
    if (targetProgress == 0) return 0;
    return currentProgress / targetProgress;
  }

  bool get isCompleted => currentProgress >= targetProgress;

  String get status {
    if (isCompleted) return 'Completed';
    if (expiresAt != null && expiresAt!.isBefore(DateTime.now())) {
      return 'Expired';
    }
    return 'Active';
  }
}

class ChallengeCategory {
  static const String checkin = 'checkin';
  static const String foodDrink = 'food_drink';
  static const String social = 'social';
  static const String music = 'music';
  static const String photo = 'photo';
  static const String special = 'special';
  
  static String getIcon(String category) {
    switch (category) {
      case checkin:
        return '📍';
      case foodDrink:
        return '🍹';
      case social:
        return '👥';
      case music:
        return '🎵';
      case photo:
        return '📸';
      case special:
        return '⭐';
      default:
        return '🎯';
    }
  }
  
  static String getDisplayName(String category) {
    switch (category) {
      case checkin:
        return 'Check-in';
      case foodDrink:
        return 'Eat & Drink';
      case social:
        return 'Socialize';
      case music:
        return 'Music';
      case photo:
        return 'Photo Missions';
      case special:
        return 'Special';
      default:
        return 'General';
    }
  }
}
