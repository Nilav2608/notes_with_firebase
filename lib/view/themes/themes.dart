import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  // textTheme: _buildTextTheme(Theme.of(context).textTheme),
  colorScheme: const ColorScheme.dark(
      background: Color(0xff252525),
      primary: Color.fromARGB(255, 59, 59, 59),
      secondary: Colors.white),
);

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        background: Colors.white,
        primary: Color(0xffF8E8EE),
        secondary: Color(0xff534747)));



  // TextTheme _buildTextTheme(BuildContext context,TextTheme base) {
  //   return GoogleFonts.nunitoTextTheme(base).copyWith(
  //       // Customize other TextTheme properties as needed
  //       );
  // }