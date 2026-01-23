import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightlifequest/challenges/challenge_model.dart';
import 'package:nightlifequest/challenges/challenge_service.dart';
import 'package:nightlifequest/core/app_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

final userChallengesProvider = FutureProvider<List<Challenge>>((ref) async {
  final challengeService = ChallengeService();
  // TODO: Get actual user ID from auth
  return await challengeService.getUserChallenges('user-id');
});

class ChallengeListPage extends ConsumerWidget {
  const ChallengeListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengesAsync = ref.watch(userChallengesProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenges'),
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {
              // TODO: Implement filter
            },
          ),
        ],
      ),
      body: challengesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (challenges) {
          if (challenges.isEmpty) {
            return _buildEmptyState();
          }
          return _buildChallengeList(challenges);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to QR scanner
        },
        backgroundColor: const Color(0xFF9D4EDD),
        child: const Icon(Icons.qr_code_scanner_rounded),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.celebration_rounded,
              size: 64,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Active Challenges',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Check into venues to unlock challenges and start earning points!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFB8B8D1),
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to map
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9D4EDD),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text('Find Venues Nearby'),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeList(List<Challenge> challenges) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        final challenge = challenges[index];
        return _buildChallengeCard(challenge);
      },
    );
  }

  Widget _buildChallengeCard(Challenge challenge) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppTheme.cardGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    challenge.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        challenge.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        challenge.description,
                        style: const TextStyle(
                          color: Color(0xFFB8B8D1),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF9D4EDD),
                        const Color(0xFF9D4EDD).withOpacity(0.7),
                    ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '+${challenge.points} pts',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Progress Bar
            LinearPercentIndicator(
              animation: true,
              lineHeight: 8,
              animationDuration: 1000,
              percent: challenge.progressPercentage.clamp(0.0, 1.0),
              backgroundColor: Colors.white.withOpacity(0.1),
              progressColor: challenge.isCompleted
                  ? const Color(0xFF4ECDC4)
                  : const Color(0xFF9D4EDD),
              barRadius: const Radius.circular(4),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${challenge.currentProgress}/${challenge.targetProgress}',
                  style: const TextStyle(
                    color: Color(0xFFB8B8D1),
                    fontSize: 12,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: challenge.isCompleted
                        ? const Color(0xFF4ECDC4).withOpacity(0.2)
                        : const Color(0xFF9D4EDD).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    challenge.status,
                    style: TextStyle(
                      color: challenge.isCompleted
                          ? const Color(0xFF4ECDC4)
                          : const Color(0xFF9D4EDD),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            if (challenge.expiresAt != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: Color(0xFFB8B8D1),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Expires ${_formatDate(challenge.expiresAt!)}',
                    style: const TextStyle(
                      color: Color(0xFFB8B8D1),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);
    
    if (difference.inDays > 0) {
      return 'in ${difference.inDays} days';
    } else if (difference.inHours > 0) {
      return 'in ${difference.inHours} hours';
    } else {
      return 'soon';
    }
  }
}
