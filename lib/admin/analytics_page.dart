import 'package:flutter/material.dart';
import 'package:nightlifequest/core/app_theme.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  String _selectedTimeRange = '7d';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Analytics',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D44),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedTimeRange,
                      dropdownColor: const Color(0xFF2D2D44),
                      icon: const Icon(Icons.arrow_drop_down_rounded,
                          color: Colors.white),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() => _selectedTimeRange = value!);
                      },
                      items: const [
                        DropdownMenuItem(
                          value: '24h',
                          child: Text('Last 24 Hours'),
                        ),
                        DropdownMenuItem(
                          value: '7d',
                          child: Text('Last 7 Days'),
                        ),
                        DropdownMenuItem(
                          value: '30d',
                          child: Text('Last 30 Days'),
                        ),
                        DropdownMenuItem(
                          value: '90d',
                          child: Text('Last 90 Days'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Top Venues
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppTheme.cardGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Top Venues by Check-ins',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildVenueRanking(
                    'Club Neon',
                    '1,248 check-ins',
                    85,
                    Colors.purple,
                  ),
                  _buildVenueRanking(
                    'Sky Bar',
                    '987 check-ins',
                    70,
                    Colors.blue,
                  ),
                  _buildVenueRanking(
                    'Bass Temple',
                    '845 check-ins',
                    60,
                    Colors.green,
                  ),
                  _buildVenueRanking(
                    'Retro Lounge',
                    '723 check-ins',
                    52,
                    Colors.orange,
                  ),
                  _buildVenueRanking(
                    'Velvet Room',
                    '612 check-ins',
                    45,
                    Colors.pink,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Challenge Analytics
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppTheme.cardGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Challenge Completion Rates',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildChallengeStat(
                    'Check-in Challenges',
                    '85%',
                    'High engagement',
                    Colors.purple,
                  ),
                  _buildChallengeStat(
                    'Social Challenges',
                    '62%',
                    'Moderate completion',
                    Colors.blue,
                  ),
                  _buildChallengeStat(
                    'Food & Drink',
                    '78%',
                    'Good participation',
                    Colors.green,
                  ),
                  _buildChallengeStat(
                    'Photo Missions',
                    '45%',
                    'Needs promotion',
                    Colors.orange,
                  ),
                  _buildChallengeStat(
                    'Song Requests',
                    '68%',
                    'Average completion',
                    Colors.pink,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // User Engagement
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppTheme.cardGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'User Engagement Metrics',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          'Avg. Session',
                          '24 min',
                          Icons.timer_rounded,
                          const Color(0xFF4ECDC4),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildMetricCard(
                          'Daily Active',
                          '327',
                          Icons.online_prediction_rounded,
                          const Color(0xFFFF6B6B),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildMetricCard(
                          'Retention (7d)',
                          '68%',
                          Icons.trending_up_rounded,
                          const Color(0xFF9D4EDD),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVenueRanking(
    String name,
    String checkins,
    int percentage,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D44),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                checkins,
                style: const TextStyle(
                  color: Color(0xFFB8B8D1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                height: 8,
                width: MediaQuery.of(context).size.width * (percentage / 100),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeStat(
    String name,
    String rate,
    String description,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D44),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.emoji_events_rounded,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFFB8B8D1),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              rate,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D44),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFB8B8D1),
            ),
          ),
        ],
      ),
    );
  }
}
