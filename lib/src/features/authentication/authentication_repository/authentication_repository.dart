import 'package:firebase_auth/firebase_auth.dart';
import '../exceptions/login_email_password_failure.dart';

class AuthenticationRepository {
  // Singleton pattern: private constructor and static instance
  AuthenticationRepository._privateConstructor();
  static final AuthenticationRepository instance = AuthenticationRepository._privateConstructor();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw LoginEmailPasswordFailure.code(e.code);
    }
  }
}
