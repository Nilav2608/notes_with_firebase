import 'package:flutter/material.dart';
import 'package:notes_with_firebase/view/pages/login_page.dart';
import 'package:notes_with_firebase/view/pages/register_page.dart';
import 'package:notes_with_firebase/view/utils/loginSignUp_buttons.dart';
// import 'package:notes_with_firebase/view/utils/loginSignUp_buttons.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    navPush() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LogInPage(),
          ));
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0x00252525),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Welcome To Notes",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Please login to your account or create new account to continue",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Image.asset("assets/introNote.png", height: 200),
              const SizedBox(
                height: 100,
              ),
              LogInSignUpButton(onPressed: () => navPush(), text: "LOGIN"),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 48,
                width: 347,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(
                          color: Color(
                              0xFF8E7CFF), // Set the desired outline color
                          width: 2.0, // Set the desired outline width
                        ),
                      ),
                    ),
                    child: const Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
