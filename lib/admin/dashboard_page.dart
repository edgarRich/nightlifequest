import 'package:flutter/material.dart';
import 'package:nightlifequest/core/app_theme.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 280,
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A2E),
              border: Border(
                right: BorderSide(color: Color(0xFF2D2D44)),
              ),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nightlife Quest',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Admin Dashboard',
                        style: TextStyle(
                          color: Color(0xFFB8B8D1),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Color(0xFF2D2D44)),
                _buildSidebarItem(
                  icon: Icons.dashboard_rounded,
                  label: 'Dashboard',
                  index: 0,
                ),
                _buildSidebarItem(
                  icon: Icons.analytics_rounded,
                  label: 'Analytics',
                  index: 1,
                ),
                _buildSidebarItem(
                  icon: Icons.business_rounded,
                  label: 'Venues',
                  index: 2,
                ),
                _buildSidebarItem(
                  icon: Icons.emoji_events_rounded,
                  label: 'Challenges',
                  index: 3,
                ),
                _buildSidebarItem(
                  icon: Icons.people_rounded,
                  label: 'Users',
                  index: 4,
                ),
                _buildSidebarItem(
                  icon: Icons.card_giftcard_rounded,
                  label: 'Rewards',
                  index: 5,
                ),
                _buildSidebarItem(
                  icon: Icons.qr_code_rounded,
                  label: 'QR Generator',
                  index: 6,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D44),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFF9D4EDD),
                        child: Icon(
                          Icons.person_rounded,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Admin User',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'admin@nightlifequest.com',
                        style: TextStyle(
                          color: Color(0xFFB8B8D1),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.logout_rounded, size: 16),
                        label: const Text('Logout'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF9D4EDD),
                          side: const BorderSide(color: Color(0xFF9D4EDD)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF9D4EDD).withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFF9D4EDD) : const Color(0xFFB8B8D1),
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFFB8B8D1),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return const AnalyticsPage();
      default:
        return Center(
          child: Text(
            'Coming Soon',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        );
    }
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard Overview',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          // Stats Grid
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildStatCard(
                'Total Users',
                '1,842',
                Icons.people_rounded,
                const Color(0xFF4ECDC4),
              ),
              _buildStatCard(
                'Active Today',
                '327',
                Icons.online_prediction_rounded,
                const Color(0xFFFF6B6B),
              ),
              _buildStatCard(
                'Total Check-ins',
                '8,459',
                Icons.qr_code_scanner_rounded,
                const Color(0xFF9D4EDD),
              ),
              _buildStatCard(
                'Points Awarded',
                '124,580',
                Icons.emoji_events_rounded,
                const Color(0xFFFFD166),
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

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.2),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const Spacer(),
              const Icon(
                Icons.trending_up_rounded,
                color: Color(0xFF4ECDC4),
              ),
              const SizedBox(width: 4),
              const Text(
                '+12%',
                style: TextStyle(
                  color: Color(0xFF4ECDC4),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
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

  Widget _buildActivityItem(String title, String time, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D44),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF9D4EDD)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFFB8B8D1),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
