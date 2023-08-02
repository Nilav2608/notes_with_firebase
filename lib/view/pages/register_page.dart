import 'package:flutter/material.dart';
import 'package:notes_with_firebase/controller/auth_service.dart';
import 'package:notes_with_firebase/view/utils/loginSignUp_buttons.dart';
import 'package:notes_with_firebase/view/utils/outlined_authbtns.dart';
import 'package:notes_with_firebase/view/utils/text_fields.dart';

class RegisterPage extends StatelessWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key,  required this.showLoginPage});

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

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0x00121212),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(
                  height: screenHeight * 0.04,
                ),
                const Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 SizedBox(
                  height: screenHeight * 0.03,
                ),
                const Text(
                  "Email",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                 SizedBox(
                  height: screenHeight * 0.01,
                ),
                MyTextField(
                  controller: emailController,
                  hint: "Enter Your Email",
                  obscure: false,
                ),
                 SizedBox(
                  height: screenHeight * 0.02,
                ),
                const Text(
                  "Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                 SizedBox(
                  height: screenHeight * 0.01,
                ),
                MyTextField(
                  controller: passwordController,
                  hint: "Enter Your Password",
                  obscure: true,
                ),
                 SizedBox(
                  height: screenHeight * 0.02,
                ),
                const Text(
                  "Confirm Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                MyTextField(
                  controller: confirmpasswordController,
                  hint: "Re Enter Your Password",
                  obscure: true,
                ),
                 SizedBox(
                  height: screenHeight * 0.04,
                ),
                LogInSignUpButton(
                  onPressed: () {
                    AuthService().signUp(
                      context,
                      passwordConfirmed(),
                      emailController.text,
                      passwordController.text,
                    );
                  },
                  text: "Register",
                ),
                 SizedBox(
                  height: screenHeight * 0.01,
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
                 SizedBox(
                  height: screenHeight * 0.01,
                ),
                OutlinedAuthButtons(
                  onPressed: () => AuthService().signInWithGoogle(context),
                  imgPath: "assets/google.png",
                  width: 20,
                  text: "Login with Google",
                ),
                 SizedBox(
                  height: screenHeight * 0.03,
                ),
                OutlinedAuthButtons(
                  onPressed: () => debugPrint("This feature is not available yet"),
                  imgPath: "assets/apple.png",
                  width: 30,
                  text: "Login with Apple",
                ),
                 SizedBox(
                  height: screenHeight * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Color(0xFF979797)),
                    ),
                    GestureDetector(
                      onTap: showLoginPage,
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
