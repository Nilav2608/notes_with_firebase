import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  // Function(String) changed;
  const MyTextField(
      {super.key,
      required this.controller,
      // required this.changed,
      required this.hint,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFF1D1D1D),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xFF979797))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          // onChanged:changed,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle:
                const TextStyle(color: Color.fromARGB(115, 255, 255, 255)),
            hintText: hint,
          ),
        ),
      ),
    );
    
  }
}


