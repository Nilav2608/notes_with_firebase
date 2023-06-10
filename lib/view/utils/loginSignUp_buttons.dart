import 'package:flutter/material.dart';

class LogInSignUpButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const LogInSignUpButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 347,
      child: ElevatedButton(
          onPressed: onPressed,
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color(0xFF8875FF))),
          child: Text(text)),
    );
  }
}
