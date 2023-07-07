import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  var ref = FirebaseFirestore.instance
      .collection("users")
      .doc(userId)
      .collection("notes")
      .get();
  // .doc();

  @override
  Widget build(BuildContext context) {
    var dataProvider = context.watch<NotesDataProvider>();
    // var provider = Provider.of<NotesDataProvider>(context, listen: false);
    List<Notes> dataNote = dataProvider.notes;

    void deleteNote(String id) {
      dataProvider.deleteRecord(id);
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: MyAppBar(
              bgColor: bgColor,
              signOut: () {
                dataProvider.signOut();
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote();
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
          // var ind = ref.doc();
          return TodoTile(
              notes: notes,
              colorRandom: bg,
              deleteNote: (context) {
                deleteNote(notes.id??'');
                debugPrint(notes.id);
              });
        },
      ),
    ));
  }

  addNote() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNote(),
        ));
  }
}
