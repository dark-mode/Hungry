import 'package:google_sign_in/google_sign_in.dart';

class SignIn {
  bool isSignedIn;
  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  GoogleSignIn get googleSignIn => _googleSignIn;

  void handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      isSignedIn = true;
    } catch (error) {
      print(error);
      isSignedIn = false;
    }
  }
}