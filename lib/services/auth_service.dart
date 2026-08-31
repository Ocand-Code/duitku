import 'package:firebase_auth/firebase_auth.dart';

/// Layanan otentikasi (email/password).
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<String?> get authState => _auth.authStateChanges().map((u) => u?.uid);

  String? get currentUid => _auth.currentUser?.uid;

  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}