import 'package:flutter/material.dart';
import 'package:notes_with_firebase/controller/stream_builder.dart';
import 'package:notes_with_firebase/view/utils/loginSignUp_buttons.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    navPush() async {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setBool("isFirstLaunch", false);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const StreamPage()),
          (route) => false);
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.04,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome To Notes",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Please login to your account or create a new account to continue",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset("assets/introNote.png", height: screenHeight * 0.2),
              const SizedBox(
                height: 30,
              ),
              LogInSignUpButton(onPressed: () => navPush(), text: "LOGIN"),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 48,
                width: screenWidth * 0.9,
                child: OutlinedButton(
                  onPressed: () => navPush(),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                        color:
                            Color(0xFF8E7CFF), // Set the desired outline color
                        width: 2.0, // Set the desired outline width
                      ),
                    ),
                  ),
                  child: Text(
                    "CREATE ACCOUNT",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
