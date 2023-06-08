import 'package:flutter/material.dart';
import 'package:notes_with_firebase/view/utils/text_fields.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0x00121212),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "LogIn",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Username",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: emailController,
                  hint: "Enter Your Username",
                  obscure: false),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Username",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: passwordController,
                  hint: "Enter Your Password",
                  obscure: true)
            ],
          ),
        ),
      ),
    );
  }
}
