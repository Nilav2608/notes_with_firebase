import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_with_firebase/controller/auth_service.dart';
import 'package:notes_with_firebase/view/pages/add_note_page.dart';
import 'package:notes_with_firebase/view/utils/app_bar.dart';
import 'package:notes_with_firebase/view/utils/tile_widget.dart';
import 'package:provider/provider.dart';

import '../../controller/data_provider.dart';
import '../../models/note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color bgColor = const Color(0x00252525);

  @override
  void initState() {
    final fetchData = Provider.of<NotesDataProvider>(context, listen: false);
    fetchData.fetchNotes();
    super.initState();
  }

  final List<int> tileColors = [
    0xFFFD99FF,
    0xFFFF9E9E,
    0xFF91F48F,
    0xFFFFF599,
    0xFF9EFFFF,
    0xFFB69CFF,
  ];

  // List<Notes> notesList = [];




  
  // mapRecords(
  //     QuerySnapshot<Map<String, dynamic>> records, BuildContext context) async {
  //   List<Notes> list = records.docs
  //       .map((item) => Notes(
  //           title: item["title"], content: item["content"], date: item["date"]))
  //       .toList();

  //   // Provider.of<NotesDataProvider>(context).addNote(notes);
  //   var dataProvider = context.watch<NotesDataProvider>();
  //   dataProvider.addNote(list as Notes);
  // }


  @override
  Widget build(BuildContext context) {
    var dataProvider = context.watch<NotesDataProvider>();
    // var dataProvider = Provider.of<NotesDataProvider>(context,listen: false);
    List<Notes> dataNote = dataProvider.notes;

    return SafeArea(
        child: Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: MyAppBar(
              bgColor: bgColor,
              signOut: () {
                AuthService().signOut();
                // var provider =
                //     Provider.of<NotesDataProvider>(context, listen: false);
                // provider.deleteAll();
                // Navigator.of(context).pop();
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  AddNote(),
              ));
        },
        backgroundColor: const Color.fromARGB(255, 59, 59, 59),
        elevation: 10,
        child: const Icon(
          Icons.add_rounded,
          size: 48,
        ),
      ),
      body: ListView.builder(
        itemCount: dataNote.length,
        itemBuilder: (context, index) {
          var random = Random();
          var bg = tileColors[random.nextInt(6)];
          var notes = dataNote[index];
          return TodoTile(
            notes: notes,
            colorRandom: bg,
          );
        },
      ),
    ));
  }
}
