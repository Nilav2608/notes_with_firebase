import 'dart:math';
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

  @override
  Widget build(BuildContext context) {
    var dataProvider = context.watch<NotesDataProvider>();
    // var provider = Provider.of<NotesDataProvider>(context, listen: false);
    List<Notes> dataNote = dataProvider.notes;
    deleteNote(id) {
      dataProvider.delete(id);
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
          return TodoTile(
            notes: notes,
            colorRandom: bg,
            deleteNote: () => deleteNote(notes),
          );
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
