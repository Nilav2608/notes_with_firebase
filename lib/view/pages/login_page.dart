import 'package:flutter/material.dart';
import 'package:notes_with_firebase/controller/auth_service.dart';
import 'package:notes_with_firebase/controller/data_provider.dart';
import 'package:notes_with_firebase/view/utils/loginSignUp_buttons.dart';
import 'package:notes_with_firebase/view/utils/outlined_authbtns.dart';
import 'package:notes_with_firebase/view/utils/text_fields.dart';
import 'package:provider/provider.dart';

import '../utils/dialogs.dart';

class LogInPage extends StatefulWidget {
  final VoidCallback showRegisterpage;
  const LogInPage({super.key, required this.showRegisterpage});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

var authService = AuthService();
var diag = Dialogs();

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    // final double screenWidht = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    var provider = Provider.of<NotesDataProvider>(context, listen: false);
    // var isValidEmail = FilteringTextInputFormatter.allow(RegExp("^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"));
    // validate(String? val) {
    //   if(val != null){

    //   }
    // }
    var key = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Form(
              key: key,
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Text(
                      "LogIn",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
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
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                            return "Enter valid email";
                          } else {
                            return null;
                          }
                        },
                        obscure: false),
                    Text(
                      provider.isTrue ? "Invaid user name" : "",
                      style: const TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                        controller: passwordController,
                        hint: "Enter Your Password",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter password";
                          } else {
                            return null;
                          }
                        },
                        obscure: true),
                    const SizedBox(
                      height: 20,
                    ),
                    LogInSignUpButton(
                        onPressed: ()  {
                          if (key.currentState!.validate()) {
                          //   SharedPreferences prefs =
                          //     await SharedPreferences.getInstance();
                          // await prefs.setBool("isFirstLaunch", false);
                            
                            authService.login(context, emailController.text,
                                passwordController.text);
                          }
                          // provider.login(context, emailController.text, passwordController.text);
                          debugPrint("logged in");
                        },
                        text: "Login"),
                    const SizedBox(
                      height: 30,
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
                    const SizedBox(
                      height: 30,
                    ),
                    OutlinedAuthButtons(
                        onPressed: () async {
                          // SharedPreferences prefs =
                          //     await SharedPreferences.getInstance();
                          // await prefs.setBool("isFirstLaunch", false);
                          // ignore: use_build_context_synchronously
                          AuthService().signInWithGoogle(context);
                        },
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
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?",
                            style: TextStyle(color: Color(0xFF979797))),
                        GestureDetector(
                            onTap: widget.showRegisterpage,
                            child: Text("Register",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
