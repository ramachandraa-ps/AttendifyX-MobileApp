class LoginWithEmailAndPasswordFailure {
  final String message;

  const LoginWithEmailAndPasswordFailure([this.message = "An error occurred."]);

  factory LoginWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'user-not-found':
        return const LoginWithEmailAndPasswordFailure('No user found for that email.');
      case 'wrong-password':
        return const LoginWithEmailAndPasswordFailure('Wrong password provided.');
      default:
        return const LoginWithEmailAndPasswordFailure();
    }
  }
}
class LoginEmailPasswordFailure {
  final String message;

  const LoginEmailPasswordFailure([this.message = "An error occurred."]);

  factory LoginEmailPasswordFailure.code(String code) {
    switch (code) {
      case 'user-not-found':
        return const LoginEmailPasswordFailure('No user found for that email.');
      case 'wrong-password':
        return const LoginEmailPasswordFailure('Wrong password provided.');
      case 'invalid-email':
        return const LoginEmailPasswordFailure('Invalid email address.');
      default:
        return const LoginEmailPasswordFailure();
    }
  }
}

