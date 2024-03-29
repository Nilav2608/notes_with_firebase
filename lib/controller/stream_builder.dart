import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_with_firebase/controller/page_switch.dart';
import 'package:notes_with_firebase/view/pages/home_page.dart';

class StreamPage extends StatelessWidget {
  const StreamPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        debugPrint("streamed data");
        if (snapshot.hasData) {
          
          return const HomePage();
        } else {
          return const PageSwitch();
        }
      },
    );
  }
}
