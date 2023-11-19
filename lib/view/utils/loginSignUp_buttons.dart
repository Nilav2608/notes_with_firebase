// ignore: file_names
import 'package:flutter/material.dart';

class LogInSignUpButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const LogInSignUpButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenWidth*0.12,
      width: screenHeight*3,
      child: ElevatedButton(
          onPressed: onPressed,
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color(0xFF8875FF))),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white
            ),
          )),
    );
  }
}
