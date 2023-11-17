import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final String? Function(String?)? validator;
  // Function(String) changed;
  const MyTextField(
      {super.key,
      required this.controller,
      // required this.changed,
      required this.hint,
      required this.obscure,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 48,
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        // onChanged:changed,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.secondary),
        decoration: InputDecoration(
          
          contentPadding: const EdgeInsets.only(left: 5),
          border: const OutlineInputBorder(
            
              borderRadius: BorderRadius.all(Radius.circular(5))),
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
          hintText: hint,
        ),
      ),
    );
  }
}
