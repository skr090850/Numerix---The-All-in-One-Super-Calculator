import 'package:firebase_auth/firebase_auth.dart';

// Yeh class Firebase Authentication se jude sabhi operations ko handle karti hai.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User ke login state mein badlav ko sunne ke liye ek stream.
  Stream<User?> get userStream => _auth.authStateChanges();

  // Current user ko get karne ke liye.
  User? get currentUser => _auth.currentUser;

  // Email aur password se sign in karne ke liye.
  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      // Error ko UI layer par handle karne ke liye re-throw kar rahe hain.
      rethrow;
    }
  }

  // Naya account register karne ke liye.
  Future<UserCredential> registerWithEmail(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      // Error ko UI layer par handle karne ke liye re-throw kar rahe hain.
      rethrow;
    }
  }

  // User ko sign out karne ke liye.
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
