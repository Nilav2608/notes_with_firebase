import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_with_firebase/controller/data_provider.dart';
import 'package:notes_with_firebase/controller/stream_builder.dart';
import 'package:notes_with_firebase/firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_with_firebase/view/pages/intro_page.dart';
import 'package:notes_with_firebase/view/themes/themes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //*sharedpreferences is used here to store local data for showing intro page or home page

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
    return ChangeNotifierProvider(
      create: (context) => NotesDataProvider(),
      builder: (context, child) =>  MaterialApp(
          
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          
          
          initialRoute: initScreen == 0 || initScreen == null? "intro" : "home",
          routes: {
            'home' :(context) => const StreamPage(),
            'intro' :(context) => const IntroPage()
          },
          
        ),
    );
  }
}
