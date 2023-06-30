import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final List<int> tileColors = [
    0xFFFD99FF,
    0xFFFF9E9E,
    0xFF91F48F,
    0xFFFFF599,
    0xFF9EFFFF,
    0xFFB69CFF,
  ];

  List<Notes> notesList = [];

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
    fetchNotes();
    ref.snapshots().listen((records) {
      mapRecords(records, context);
    });
    super.initState();
  }

  final userId = FirebaseAuth.instance.currentUser?.uid;

  Future fetchNotes() async {
    if (userId != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("notes")
          .get();
      // print('get executed!');
      notesList = snapshot.docs
          .map((items) => Notes(
              title: items["title"],
              content: items["content"],
              date: items["date"].toString()))
          .toList();
      // notesList.add(list as Notes);

      // print('notes are displayed');
      // ignore: use_build_context_synchronously
      var dataProvider = Provider.of<NotesDataProvider>(context, listen: false);
      for (var element in notesList) {
        dataProvider.addNote(element);
      }
    }
  }

  mapRecords(
      QuerySnapshot<Map<String, dynamic>> records, BuildContext context) {
    List<Notes> list = records.docs
        .map((item) => Notes(
            title: item["title"], content: item["content"], date: item["date"]))
        .toList();

    // Provider.of<NotesDataProvider>(context).addNote(notes);
    var dataProvider = context.watch<NotesDataProvider>();
    dataProvider.addNote(list as Notes);
  }

  void add(BuildContext context, title, content, date) async {
    if (userId != null) {
      DocumentReference parentDocRef =
          FirebaseFirestore.instance.collection("users").doc(userId);

      CollectionReference childCollRef = parentDocRef.collection("notes");

      var data = Notes(
          title: title, content: content, date: DateTime.now().toString());

      var id = await childCollRef.add(data.toJson());

      debugPrint("sussessful $id");

      // ignore: use_build_context_synchronously
      var dataProvider = Provider.of<NotesDataProvider>(context);
      dataProvider.addNote(data);
      debugPrint("added to provider $id");
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var dataProvider = context.watch<NotesDataProvider>().notes;
    // List<Notes> dataNote = dataProvider.notes;

    return SafeArea(
        child: Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: MyAppBar(
              bgColor: bgColor,
              signOut: () {
                AuthService().signOut();
                var provider = Provider.of<NotesDataProvider>(context);
                provider.deleteAll();
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNote(),
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
        itemCount: dataProvider.length,
        itemBuilder: (context, index) {
          var random = Random();
          var bg = tileColors[random.nextInt(6)];
          var notes = dataProvider[index];
          return TodoTile(
            notes: notes,
            colorRandom: bg,
          );
        },
      ),
    ));
  }
}
