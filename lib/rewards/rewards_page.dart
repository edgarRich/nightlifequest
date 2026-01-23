import 'package:flutter/material.dart';
import 'package:nightlifequest/core/app_theme.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  int _userPoints = 2450; // TODO: Get from user profile
  int _selectedCategory = 0;
  
  final List<String> _categories = ['All', 'Drinks', 'Access', 'Events', 'Merch'];
  
  final List<Map<String, dynamic>> _rewards = [
    {
      'title': 'Free Cocktail',
      'description': 'Any signature cocktail',
      'points': 500,
      'category': 'Drinks',
      'icon': '🍸',
      'color': Colors.purple,
    },
    {
      'title': 'VIP Access',
      'description': 'Skip the line + VIP area',
      'points': 1000,
      'category': 'Access',
      'icon': '🎫',
      'color': Colors.blue,
    },
    {
      'title': 'Bottle Service',
      'description': 'Premium bottle + mixers',
      'points': 2500,
      'category': 'Drinks',
      'icon': '🍾',
      'color': Colors.purple,
    },
    {
      'title': 'Concert Tickets',
      'description': 'Upcoming artist performance',
      'points': 3000,
      'category': 'Events',
      'icon': '🎵',
      'color': Colors.green,
    },
    {
      'title': 'Luxury Dinner',
      'description': 'Fine dining experience',
      'points': 4000,
      'category': 'Events',
      'icon': '🍽️',
      'color': Colors.green,
    },
    {
      'title': 'Exclusive Hoodie',
      'description': 'Limited edition merch',
      'points': 1500,
      'category': 'Merch',
      'icon': '👕',
      'color': Colors.orange,
    },
    {
      'title': 'DJ Workshop',
      'description': 'Learn from top DJs',
      'points': 3500,
      'category': 'Events',
      'icon': '🎧',
      'color': Colors.green,
    },
    {
      'title': 'Brunch Pass',
      'description': 'Weekend brunch for two',
      'points': 1200,
      'category': 'Events',
      'icon': '☕',
      'color': Colors.green,
    },
  ];
  
  final List<Map<String, dynamic>> _badges = [
    {'icon': '🦋', 'name': 'Social Butterfly', 'earned': true},
    {'icon': '🦉', 'name': 'Night Owl', 'earned': true},
    {'icon': '🎧', 'name': 'Vibe Master', 'earned': true},
    {'icon': '✨', 'name': 'Star Explorer', 'earned': false},
    {'icon': '👑', 'name': 'Club Royalty', 'earned': false},
    {'icon': '🎉', 'name': 'Party Legend', 'earned': false},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredRewards = _selectedCategory == 0
        ? _rewards
        : _rewards.where((r) => 
            r['category'] == _categories[_selectedCategory]).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            backgroundColor: const Color(0xFF1A1A2E),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Points',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            _userPoints.toString(),
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.emoji_events_rounded,
                            color: Colors.amber,
                            size: 32,
                          ),
                        ],
                      ),
                      const SizedBox(height:
