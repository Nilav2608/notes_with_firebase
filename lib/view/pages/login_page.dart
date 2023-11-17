import 'package:flutter/material.dart';
import 'package:notes_with_firebase/controller/auth_service.dart';
import 'package:notes_with_firebase/controller/data_provider.dart';
import 'package:notes_with_firebase/view/utils/loginSignUp_buttons.dart';
import 'package:notes_with_firebase/view/utils/outlined_authbtns.dart';
import 'package:notes_with_firebase/view/utils/text_fields.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  final VoidCallback showRegisterpage;
  const LogInPage({super.key, required this.showRegisterpage});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                   Text(
                    "LogIn",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                   Text(
                    "Email",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                      controller: emailController,
                      hint: "Enter Your Email",
                      // changed: (value) {
                      //   validate(value);
                      // },
                      obscure: false),
                  Text(
                    provider.isTrue ? "Invaid user name" : "",
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 10,
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
                      // changed: (value) {
                      //   validate(value);
                      // },
                      obscure: true),
                  Text(
                    provider.isTrue ? "Invaid password" : "",
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LogInSignUpButton(
                      onPressed: () {
                        AuthService().login(context, emailController.text,
                            passwordController.text);
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
                      onPressed: () => AuthService().signInWithGoogle(context),
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
                          child:  Text("Register",
                              style: TextStyle(color: Theme.of(context).colorScheme.secondary))),
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
