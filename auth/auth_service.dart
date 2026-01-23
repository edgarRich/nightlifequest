
Future<void> signInWithGoogle() async {
  await Supabase.instance.client.auth.signInWithOAuth(
    OAuthProvider.google,
  );
}
