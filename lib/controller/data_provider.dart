import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/note_model.dart';

class NotesDataProvider extends ChangeNotifier {
  List<Notes> notesList = [];

  Future<void> fetchNotes() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("notes")
          .get();
      print('get executed!');
       notesList = snapshot.docs
          .map((items) => Notes(
            title: items["title"], 
            content: items["content"], 
            date: items["date"].toString()
            ))
          .toList();
      // notesList.add(list as Notes);

      print('notes are added');
      notifyListeners();
    }
  }

  getNote() {
    return notesList;
  }

  addNote(Notes notes) {
    notesList.add(notes);
    notifyListeners();
  }
}
