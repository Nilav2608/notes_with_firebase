import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        if (e.code == 'user-not-found') {
          debugPrint("user not found");
        } else if (e.code == 'wrong-password') {
          debugPrint("wrong-password");
        }
      }
  }

  Future login(BuildContext context, String emailController, String passwordController ) async {
      showDialog(
          context: context,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController, password: passwordController);
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
        
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          debugPrint("user not found");
        } else if (e.code == 'wrong-password') {
          debugPrint("wrong-password");
        }
      }
      
    }
    

    Future signUp(BuildContext context, bool pass, emailController, String passwordController ) async {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      if (pass) {
        final authResult = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController, password: passwordController);

        final User? user = authResult.user;
        return user;
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Both passwords are no the same"),
              );
            });
      }
    }
    

  signOut() async {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
  }
}
