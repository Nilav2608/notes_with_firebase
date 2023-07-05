import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:notes_with_firebase/view/utils/dialogs.dart';

class AuthService extends Dialogs {
  //*Google SignIn function
  var diag = Dialogs();
  CollectionReference collection =
      FirebaseFirestore.instance.collection("users");

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      //*getting the userResult authenticated with credentials
      final UserCredential authResults =
          await FirebaseAuth.instance.signInWithCredential(credential);

      //* we are getting the user from the  authenticated resluts
      final User? user = authResults.user;

      Map<String, dynamic> userData = {
        "name": user!.displayName,
        "provider": "google",
        "photoUrl": user.photoURL,
        "email": user.email,
      };

      //!here we getting the uid form the collection
      collection.doc(user.uid).get().then((id) {
        if (id.exists) {
          id.reference.update(userData);
        } else {
          collection.doc(user.uid).set(userData);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint("user not found");
      } else if (e.code == 'wrong-password') {
        debugPrint("wrong-password");
      }
    }
  }

  //*LogIn with email and password

  Future login(BuildContext context, String emailController,
      String passwordController) async {
    diag.circularProgress(context);
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

  //* SignUp with email and password

  Future signUp(BuildContext context, bool pass, emailController,
      String passwordController) async {
    diag.circularProgress(context);
    if (pass) {
      final UserCredential authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController, password: passwordController);

      var user = authResult.user;
      var email = user!.email;
      var name1 = email!.split("@");
      Map<String, dynamic> userData = {
        "name": name1[0],
        "provider": "email and password",
        "photoUrl": user.photoURL,
        "email": user.email,
      };

      collection.doc(user.uid).get().then((id) => {
            if (id.exists)
              {id.reference.update(userData)}
            else
              {collection.doc(user.uid).set(userData)}
          });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
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

  
}
