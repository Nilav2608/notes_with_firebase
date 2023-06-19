import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_with_firebase/controller/auth_service.dart';
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

    bool passwordConfirmed() {
      if (passwordController.text == confirmpasswordController.text) {
        return true;
      } else {
        return false;
      }
    }

    Future signUp() async {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      if (passwordConfirmed()) {
        final authResult = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

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
                  "Email",
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
                    hint: "Enter Your Email",
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
                LogInSignUpButton(
                    onPressed: () {
                      signUp();
                    },
                    text: "Register"),
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
                OutlinedAuthButtons(
                    onPressed: () => AuthService().signInWithGoogle(),
                    imgPath: "assets/google.png",
                    width: 20,
                    text: "Login with Google"),
                const SizedBox(
                  height: 20,
                ),
                OutlinedAuthButtons(
                    onPressed: () =>
                        debugPrint("this feature is not available yet"),
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
                        onTap: showLoginpage,
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
