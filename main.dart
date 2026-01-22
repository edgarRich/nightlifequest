void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://snrjfbzvfjshlkmwtaxl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNucmpmYnp2ZmpzaGxrbXd0YXhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjkxMDYwODUsImV4cCI6MjA4NDY4MjA4NX0.4V28gr1nbVH11TZ3UqjwLr97q2uMFDusULcEviMfXEg',
  );

  runApp(const MyApp());
}
