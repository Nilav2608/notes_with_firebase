

import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_with_firebase/controller/auth_service.dart';

 enum AuthenticationMethod {
  EmailPassword,
  GoogleSignIn,
}

Future<void> signIn(AuthenticationMethod method, {required String email, required String password}) async {
  // try {
  //   switch (method) {
  //     case AuthenticationMethod.EmailPassword:
  //       UserCredential userCredential = await signInWithEmailAndPassword(email, password);
  //       if (userCredential != null) {
  //         String uid = userCredential.user.uid;
  //         // Continue with further actions using the UID
  //       }
  //       break;

  //     case AuthenticationMethod.GoogleSignIn:
  //       UserCredential userCredential = await AuthService().signInWithGoogle();
  //       if (userCredential != null) {
  //         String uid = userCredential.user.uid;
  //         // Continue with further actions using the UID
  //       }
  //       break;
  //   }
  // } catch (e) {
  //   // Handle any errors
  //   print('Error signing in: $e');
  // }
}
