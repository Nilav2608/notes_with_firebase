import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      final authResults =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = authResults.user;
      return user;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<String> cred() async {
    UserCredential credential = await signInWithGoogle();

    String uid = credential.user!.uid;
    return uid;
  }

  signOut() async {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
  }
}
