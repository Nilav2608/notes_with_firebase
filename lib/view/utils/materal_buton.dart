import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  VoidCallback onPressed;
  final Color color;
  final String text;
  Button(
      {super.key,
      required this.onPressed,
      required this.color,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 40,
      child: MaterialButton(
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
