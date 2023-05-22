import 'package:flutter/material.dart';
import 'package:notes_with_firebase/view/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  TextTheme _buildTextTheme(TextTheme base) {
  return GoogleFonts.nunitoTextTheme(base).copyWith(
    // Customize other TextTheme properties as needed
  );
}


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: _buildTextTheme(ThemeData.light().textTheme),
      ),
      home: const HomePage()
    );
  }
}
