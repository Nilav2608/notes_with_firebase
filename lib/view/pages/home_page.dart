import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_with_firebase/controller/auth_service.dart';
// import 'package:intl/intl.dart';
// import 'package:notes_with_firebase/view/pages/edit_note.dart';
// import 'package:notes_with_firebase/models/note_model.dart';
import 'package:notes_with_firebase/view/pages/add_note_page.dart';
import 'package:notes_with_firebase/view/utils/tile_widget.dart';
import 'package:provider/provider.dart';

import '../../controller/data_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color bgColor = const Color(0x00252525);

  final List<int> tileColors = [
    0xFFFD99FF,
    0xFFFF9E9E,
    0xFF91F48F,
    0xFFFFF599,
    0xFF9EFFFF,
    0xFFB69CFF,
  ];

  // List<Notes> notesList = [];
  //   String? userId = FirebaseAuth.instance.currentUser?.uid;

  // DocumentReference parentDocRef =
  //         FirebaseFirestore.instance.collection("users").doc(userId);

  //     CollectionReference childCollRef = parentDocRef.collection("notes");
  var ref = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("notes");

  @override
  void initState() {
    Future.microtask(
        () => Provider.of<NotesDataProvider>(context, listen: false).fetchNotes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Consumer<NotesDataProvider>(
          builder:(context, value, child) =>  Scaffold(
              backgroundColor: bgColor,
              appBar: AppBar(
                backgroundColor: bgColor,
                elevation: 0,
                title: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Notes",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () => AuthService().signOut(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 59, 59, 59),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(
                            Icons.logout_rounded,
                            size: 24,
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 59, 59, 59),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(
                          Icons.info_outline,
                          size: 24,
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNote(),
                      )).then((value) {
                    setState(() {});
                  });
                },
                backgroundColor: const Color.fromARGB(255, 59, 59, 59),
                elevation: 10,
                child: const Icon(
                  Icons.add_rounded,
                  size: 48,
                ),
              ),
              body:ListView.builder(
                    itemCount: value.notesList.length,
                    itemBuilder: (context, index) {
                      var random = Random();
                      var bg = tileColors[random.nextInt(6)];
                      var notes = value.getNote()[index];
                      return  TodoTile(
                        notes:notes ,
                          
                          colorRandom: bg,
                        );
                    },
                  )
                ),
        ));
  }
}
