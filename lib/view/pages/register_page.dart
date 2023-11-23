// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:notes_with_firebase/controller/auth_service.dart';
import 'package:notes_with_firebase/view/utils/loginSignUp_buttons.dart';
import 'package:notes_with_firebase/view/utils/outlined_authbtns.dart';
import 'package:notes_with_firebase/view/utils/text_fields.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmpasswordController = TextEditingController();


 


class _RegisterPageState extends State<RegisterPage> {

    @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    confirmpasswordController.clear();
    super.dispose();
  }
  
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool passwordConfirmed() {
  if (passwordController.text == confirmpasswordController.text) {
    return true;
  } else {
    return false;
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.04,
            ),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Text(
                    "Register",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
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
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                        return "Enter valid email";
                      } else {
                        return null;
                      }
                    },
                    //  changed: (value) {
                    //         // validate(value);
                    //       },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
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
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                        return "Enter valid password";
                      } else {
                        return null;
                      }
                    },
                    // changed: (p0) =>  validate(p0)
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    "Confirm Password",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please re-enter your password";
                      } else if (!passwordConfirmed()) {
                        return "our password didn't match";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  LogInSignUpButton(
                    onPressed: ()  {
                      if (formkey.currentState!.validate())  {
                        // SharedPreferences prefs =
                        //       await SharedPreferences.getInstance();
                        //   await prefs.setBool("isFirstLaunch", false);
                       
                        AuthService().signUp(
                          context,
                          passwordConfirmed(),
                          emailController.text,
                          passwordController.text,
                        );
                      }
                    },
                    text: "Register",
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Color(0xFF979797),
                        ),
                      ),
                      Text(
                        "Or",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 16,
                        ),
                      ),
                      const Expanded(
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
                    onPressed: ()  {
                          // SharedPreferences prefs =
                          //     await SharedPreferences.getInstance();
                          // await prefs.setBool("isFirstLaunch", false);
            
                          AuthService().signInWithGoogle(context);
                        },
                    imgPath: "assets/google.png",
                    width: 20,
                    text: "Login with Google",
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  OutlinedAuthButtons(
                    onPressed: () =>
                        debugPrint("This feature is not available yet"),
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
                        onTap: widget.showLoginPage,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
