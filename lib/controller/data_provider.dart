import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/note_model.dart';
import 'dart:math';

class NotesDataProvider with ChangeNotifier {
  List<Notes> _notesList = [];

  List<Notes> get notes => _notesList;

  getNote() {
    return _notesList;
  }

  addNote(Notes note) {
    _notesList.add(note);
    notifyListeners();
  }

  deleteAll() {
    _notesList.clear();
    notifyListeners();
  }

  final List<int> tileColors = [
    0xFFFD99FF,
    0xFFFF9E9E,
    0xFF91F48F,
    0xFFFFF599,
    0xFF9EFFFF,
    0xFFB69CFF,
  ];
  var random = Random();

  final userId = FirebaseAuth.instance.currentUser?.uid;
  final snapshot = FirebaseFirestore.instance.collection("users");

  Future fetchNotes() async {
    // _notesList = [];
    if (userId != null) {
      var snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("notes")
          .get();
      debugPrint('get executed!');
      mapRecords(snapshot);

      debugPrint('notes are displayed');
      notifyListeners();
    }
    // notifyListeners();
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> snapshot) {
    _notesList = snapshot.docs
        .map((items) => Notes(
            id: items.id,
            title: items["title"],
            content: items["content"],
            date: items["date"].toString(),
            color: items['color']))
        .toList();
    notifyListeners();
  }

  void add(BuildContext context, title, content) async {
    if (userId != null) {
      DocumentReference parentDocRef =
          FirebaseFirestore.instance.collection("users").doc(userId);

      CollectionReference childCollRef = parentDocRef.collection("notes");

      var bg = tileColors[random.nextInt(6)];
      Notes data = Notes(
          id: "",
          title: title,
          content: content,
          color: bg.toString(),
          date: DateTime.now().toString());
      fetchNotes();

      childCollRef.add(data.toJson()).then((DocumentReference reference) =>
          reference.update({'id': reference.id}));

      fetchNotes();
      // notifyListeners();
      // var newNote = dummy.toList();
      addNote(data);
      // fetchNotes();
      notifyListeners();
      // delete(id.toString());

      // debugPrint("sussessful $docId");
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future deleteRecord(String id) async {
    try {
      debugPrint("provider delete");
      DocumentReference parentDocRef =
          FirebaseFirestore.instance.collection("users").doc(userId);

       parentDocRef.collection("notes").doc(id).delete();

      _notesList.removeWhere((note) => note.id == id);

      notifyListeners();
      debugPrint("deleted");
    } on FirebaseException {
      debugPrint("asdf");
    }
  }

  signOut() async {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
    _notesList.clear();
  }
}
