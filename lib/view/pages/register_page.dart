import 'package:flutter/material.dart';
import 'package:notes_with_firebase/view/utils/loginSignUp_buttons.dart';
import 'package:notes_with_firebase/view/utils/outlined_authbtns.dart';
import 'package:notes_with_firebase/view/utils/text_fields.dart';

class RegisterPage extends StatelessWidget {
  final VoidCallback showLoginpage;
  const RegisterPage({super.key, required this.showLoginpage});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmpasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0x00121212),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                  "Register",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
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
                  "Password",
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
                    obscure: true),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Confirm Passsword",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: confirmpasswordController,
                    hint: "Re Enter Your Password",
                    obscure: true),
                const SizedBox(
                  height: 40,
                ),
                LogInSignUpButton(onPressed: () {}, text: "LOGIN"),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(0xFF979797),
                      ),
                    ),
                    Text(
                      "Or",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFF979797),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const OutlinedAuthButtons(
                    imgPath: "assets/google.png",
                    width: 20,
                    text: "Login with Google"),
                const SizedBox(
                  height: 20,
                ),
                const OutlinedAuthButtons(
                    imgPath: "assets/apple.png",
                    width: 30,
                    text: "Login with Apple"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Alreaady have an account?",
                        style: TextStyle(color: Color(0xFF979797))),
                    GestureDetector(
                        onTap:showLoginpage,
                        child: const Text("Login",
                            style: TextStyle(color: Colors.white))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
