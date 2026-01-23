import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nightlifequest/core/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://snrjfbzvfjshlkmwtaxl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNucmpmYnp2ZmpzaGxrbXd0YXhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjkxMDYwODUsImV4cCI6MjA4NDY4MjA4NX0.4V28gr1nbVH11TZ3UqjwLr97q2uMFDusULcEviMfXEg',
  );
  runApp(const ProviderScope(child: NightlifeQuestApp()));
}

class NightlifeQuestApp extends ConsumerWidget {
  const NightlifeQuestApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Nightlife Quest',
      theme: AppTheme.light(Color(0xFF2563EB)),
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }

  final GoRouter _router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/challenges',
        builder: (context, state) => const ChallengeListPage(),
      ),
      GoRoute(
        path: '/scan',
        builder: (context, state) => const QRScannerPage(),
      ),
      GoRoute(
        path: '/rewards',
        builder: (context, state) => const RewardsPage(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminDashboardPage(),
      ),
    ],
  );
}
