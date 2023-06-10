import 'package:flutter/material.dart';

class OutlinedAuthButtons extends StatelessWidget {
  final String text;
  final String imgPath;
  const OutlinedAuthButtons(
      {super.key, required this.imgPath, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 347,
      child: OutlinedButton(
          onPressed: () {},
          style: ButtonStyle(
            side: MaterialStateProperty.all<BorderSide>(
              const BorderSide(
                color: Color(0xFF8E7CFF), // Set the desired outline color
                width: 2.0, // Set the desired outline width
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imgPath,width: 25,),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: const TextStyle(color: Colors.white),
              )
            ],
          )),
    );
  }
}
