Widget _buildDashboard() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Control Room',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        // KPI Cards – Control Room Style
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildStatCard(
              'Active Users',
              '327',
              Icons.person_outline_rounded,
              const Color(0xFF4ECDC4), // Teal – live activity
            ),
            _buildStatCard(
              'Check-ins Today',
              '128',
              Icons.qr_code_scanner_rounded,
              const Color(0xFFFF6B6B), // Coral – action-oriented
            ),
            _buildStatCard(
              'Rewards Redeemed',
              '42',
              Icons.card_giftcard_rounded,
              const Color(0xFFFFD166), // Yellow – reward highlight
            ),
            _buildStatCard(
              'Peak Hour',
              '9 PM',
              Icons.access_time_rounded,
              const Color(0xFF9D4EDD), // Purple – brand-aligned
            ),
          ],
        ),
        const SizedBox(height: 32),
        // Recent Activity
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
                'Recent Activity',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              _buildActivityItem(
                'NightOwl_Alex checked in at Club Neon',
                '10 minutes ago',
                Icons.qr_code_scanner_rounded,
              ),
              _buildActivityItem(
                'VibeMaster_Sam completed "Social Butterfly" challenge',
                '25 minutes ago',
                Icons.emoji_events_rounded,
              ),
              _buildActivityItem(
                'New venue "Sky Bar" added',
                '1 hour ago',
                Icons.business_rounded,
              ),
              _buildActivityItem(
                'ClubKing_Mike redeemed VIP Access',
                '2 hours ago',
                Icons.card_giftcard_rounded,
              ),
              _buildActivityItem(
                'PartyPro_Lisa reached VIP Level',
                '3 hours ago',
                Icons.star_rounded,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
