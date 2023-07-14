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
    fetchData.getUid();
    fetchData.fetchNotes();
    FirebaseFirestore.instance
        .collection("users")
        .doc(fetchData.user)
        .collection("notes").orderBy("date",descending: true)
        .snapshots()
        .listen((event) {
      fetchData.mapRecords(event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dataProvider = context.watch<NotesDataProvider>();
    // var provider = Provider.of<NotesDataProvider>(context, listen: false);
    List<Notes> dataNote = dataProvider.notes;

    void deleteNote(String id) {
      dataProvider.deleteRecord(id);
    }
    //  var snapshot =  FirebaseFirestore.instance
    //       .collection("users")
    //       .doc(userId)
    //       .collection("notes")
    //       .get();

    return SafeArea(
        child: Scaffold(
            backgroundColor: bgColor,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: MyAppBar(
                    bgColor: bgColor,
                    signOut: () {
                      dataProvider.signOut(context);
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
                // var bg = tileColors[random.nextInt(6)];
                var notes = dataNote[index];
                return TodoTile(
                    notes: notes,
                    colorRandom: int.parse(notes.color ?? ''),
                    deleteNote: (context) {
                      deleteNote(notes.id!);
                      debugPrint(notes.id);
                    });
              },
            )));
  }

  addNote() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNote(),
        ));
  }
}
