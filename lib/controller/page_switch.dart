import 'package:flutter/material.dart';
import 'package:notes_with_firebase/view/pages/login_page.dart';
import 'package:notes_with_firebase/view/pages/register_page.dart';

class PageSwitch extends StatefulWidget {
  const PageSwitch({super.key});

  @override
  State<PageSwitch> createState() => _PageSwitchState();
}

class _PageSwitchState extends State<PageSwitch> {
  bool showLoginPage = true;

  toggle() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LogInPage(showRegisterpage: () => toggle(),);
    } else {
      return RegisterPage(showLoginpage: () => toggle(),);
    }
  }
}
