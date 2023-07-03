import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note_model.dart';

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

  final userId = FirebaseAuth.instance.currentUser?.uid;

  Future fetchNotes() async {
    if (userId != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("notes")
          .get();
      // print('get executed!');
      _notesList = snapshot.docs
          .map((items) => Notes(
              title: items["title"],
              content: items["content"],
              date: items["date"].toString()))
          .toList();
      // notesList.add(list as Notes);

      print('notes are displayed');
      notifyListeners();
    }
    notifyListeners();
  }

  void add(BuildContext context, title, content) async {
    if (userId != null) {
      DocumentReference parentDocRef =
          FirebaseFirestore.instance.collection("users").doc(userId);

      CollectionReference childCollRef = parentDocRef.collection("notes");

      var data = Notes(
          title: title, content: content, date: DateTime.now().toString());

      var id = await childCollRef.add(data.toJson());
      addNote(data);
      notifyListeners();

      debugPrint("sussessful $id");
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    notifyListeners();
  }

  delete() {
    // if (userId != null) {
    //   DocumentReference parentDocRef =
    //       FirebaseFirestore.instance.collection("users").doc(userId);

    //   CollectionReference childCollRef = parentDocRef.collection("notes");
    //   childCollRef.doc(id).delete();

    // }
    debugPrint("deleted");
  }
}
