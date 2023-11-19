import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_with_firebase/view/pages/add_note_page.dart';
import 'package:notes_with_firebase/view/pages/edit_note.dart';
import 'package:notes_with_firebase/view/utils/app_bar.dart';
import 'package:notes_with_firebase/view/utils/tile_widget.dart';
import 'package:provider/provider.dart';

import '../../controller/data_provider.dart';
import '../../models/note_model.dart';
import '../utils/dialogs.dart';

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
        .doc(fetchData.userID)
        .collection("notes")
        .orderBy("date", descending: true)
        .snapshots()
        .listen((event) {
      fetchData.mapRecords(event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var diag = Dialogs();
    var dataProvider = context.watch<NotesDataProvider>();
    // var provider = Provider.of<NotesDataProvider>(context, listen: false);
    List<Notes> dataNote = dataProvider.notes;

    void deleteNote(String id) {
      dataProvider.deleteRecord(id);
    }

    return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: MyAppBar(
          // bgColor: bgColor,
          signOut: ()  {
        // diag.circularProgress(context);
         dataProvider.signOut(context);
      })),
          floatingActionButton: FloatingActionButton(
    onPressed: () {
      addNote();
    },
    // backgroundColor: const Color.fromARGB(255, 59, 59, 59),
    backgroundColor: Theme.of(context).colorScheme.primary,
    elevation: 10,
    child: Icon(
      Icons.add_rounded,
      color: Theme.of(context).colorScheme.secondary,
      size: 28,
    ),
          ),
          body: Consumer<NotesDataProvider>(
    builder: (context, value, child) {
      if (value.notes.isEmpty) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/rafiki.png"),
              Text(
                "Create your first note!",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary),
              )
            ],
          ),
        );
      } else {
        return ListView.builder(
          itemCount: dataNote.length,
          itemBuilder: (context, index) {
            // var bg = tileColors[random.nextInt(6)];
            var notes = dataNote[index];
              return InkWell(
                onTap: () => editNote(notes),
                child: TodoTile(
                    notes: notes,
                    colorRandom: int.parse(notes.color ?? ''),
                    deleteNote: (context) {
                      deleteNote(notes.id!);
                      debugPrint(notes.id);
                    }),
              );
            
          },
        );
      }
    },
          ),
        );
  }

  addNote() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNote(),
        ));
  }

  editNote(Notes note) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditNote(note: note),
        ));
  }
}
