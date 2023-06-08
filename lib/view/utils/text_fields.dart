import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFF1D1D1D), 
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: const Color(0xFF979797)
          )
           
        ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: TextField(
          controller: controller,
          obscureText: obscure,
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
    // TextField(
    //   controller: controller,
    //   obscureText: obscure,
    //   decoration: InputDecoration(

    //       hintText: hint,
    //       fillColor: Color.fromARGB(0, 98, 179, 69),
    //       filled: true,
    //       focusedBorder: const OutlineInputBorder(
    //           borderSide: BorderSide(color: Color(0x00979797))),
    //       enabledBorder: OutlineInputBorder(
    //           borderSide: BorderSide(color: Colors.grey.shade100)),
    //       hintStyle: TextStyle(color: Colors.grey.shade500)
    //    ),
    // );
  }
}



//  Container(
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 62, 62, 85),
//                               borderRadius: BorderRadius.circular(12)),
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 20.0),
//                             child: TextField(
//                               controller: emailController,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white),
//                               decoration: const InputDecoration(
//                                 border: InputBorder.none,
//                                 hintStyle: TextStyle(
//                                     color: Color.fromARGB(115, 255, 255, 255)),
//                                 hintText: 'Enter your email',
//                               ),
//                             ),
//                           ),
//                         ),