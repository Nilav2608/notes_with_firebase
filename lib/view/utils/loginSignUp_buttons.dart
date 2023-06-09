// ignore: file_names
import 'package:flutter/material.dart';

class LogInSignUpButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const LogInSignUpButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 347,
      child: ElevatedButton(
          onPressed: () {},
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color(0xFF8875FF))),
          child: const Text("LOGIN")),
    );
  }
}
