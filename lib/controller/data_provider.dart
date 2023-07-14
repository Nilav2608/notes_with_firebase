import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_with_firebase/view/utils/dialogs.dart';
import '../models/note_model.dart';
import 'dart:math';

class NotesDataProvider with ChangeNotifier {
  List<Notes> _notesList = [];

  List<Notes> get notes => _notesList;
  var diag = Dialogs();
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
  // ignore: prefer_typing_uninitialized_variables
  var user;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final snapshot = FirebaseFirestore.instance.collection("users");

  getUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser!.uid;
  }

  fetchNotes() async {
    // _notesList = [];

    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user)
        .collection("notes")
        .get();
    debugPrint('get executed!');
    mapRecords(snapshot);

    debugPrint('notes are displayed');
    notifyListeners();
  }
  // notifyListeners();

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
    DocumentReference parentDocRef =
        FirebaseFirestore.instance.collection("users").doc(user);

    CollectionReference childCollRef = parentDocRef.collection("notes");

    var bg = tileColors[random.nextInt(6)];
    Notes data = Notes(
        id: "",
        title: title,
        content: content,
        color: bg.toString(),
        date: DateTime.now().toString());
    debugPrint("sussessful id updated 1 ");
    childCollRef.add(data.toJson()).then((DocumentReference reference) =>
        reference.update({'id': reference.id}));
    // DocumentReference newNoteRef = await childCollRef.add(data.toJson());
    // String newNoteId = newNoteRef.id;

    // await newNoteRef.update({'id': newNoteId});
    debugPrint("sussessful id updated 2");
    // data.id = newNoteId;
    addNote(data);
    // fetchNotes();
    notifyListeners();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future deleteRecord(String id) async {
    try {
      debugPrint("provider delete");
      DocumentReference parentDocRef =
          FirebaseFirestore.instance.collection("users").doc(userId);

      await parentDocRef.collection("notes").doc(id).delete();

      _notesList.removeWhere((note) => note.id == id);

      notifyListeners();
      debugPrint("deleted");
    } on FirebaseException {
      debugPrint("asdf");
    }
  }

  signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      await GoogleSignIn().signOut();
      deleteAll();
      debugPrint("inner notes deleted");

      notifyListeners();
    } on FirebaseException {
      debugPrint("asdf");
    }
  }
}
