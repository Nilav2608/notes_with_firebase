import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
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

  //invalid password
  bool _validEmailOrPassword = false;
  // bool validUserName = false;

  get isTrue => _validEmailOrPassword;

  void invalidPasseord(bool val) async {
    _validEmailOrPassword = val;
    debugPrint("method invoked");
    notifyListeners();
  }

  // void invalidUsername() {
  //   validUserName = true;
  //   notifyListeners();
  // }
  // Future login(BuildContext context, String emailController,
  //     String passwordController) async {
  //   // var provider = Provider.of<NotesDataProvider>(context, listen: false);

  //   diag.circularProgress(context);
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailController, password: passwordController);
  //     await FirebaseAuth.instance.currentUser?.reload();
  //     // ignore: use_build_context_synchronously
  //     Navigator.pop(context);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       // provider.invalidPasseord(true);
  //        _validEmailOrPassword = false;
  //        notifyListeners();
  //       // ignore: use_build_context_synchronously
  //       Navigator.pop(context);
  //       debugPrint("user not found");
  //     } else if (e.code == 'wrong-password') {
  //       // provider.invalidPasseord(true);
  //       _validEmailOrPassword = false;
  //       notifyListeners();
  //       // ignore: use_build_context_synchronously
  //       Navigator.pop(context);
  //       debugPrint("wrong-password");
  //     }
  //   }
  // }

  var userID = "";
  getUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    userID = auth.currentUser!.uid;
  }

  fetchNotes() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .collection("notes")
        .orderBy("date", descending: true)
        .get();
    debugPrint('get executed!');
    mapRecords(snapshot);

    debugPrint('notes are displayed');
    notifyListeners();
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

  DateTime date = DateTime.now();

  void add(BuildContext context, title, content) async {
    DocumentReference parentDocRef =
        FirebaseFirestore.instance.collection("users").doc(userID);

    CollectionReference childCollRef = parentDocRef.collection("notes");

    var bg = tileColors[random.nextInt(6)];
    String formatDate = DateFormat('dd/MM/yy').format(date);
    Notes data = Notes(
        id: "",
        title: title,
        content: content,
        color: bg.toString(),
        date: formatDate);
    debugPrint("sussessful id updated 1 ");
    childCollRef.add(data.toJson()).then((DocumentReference reference) =>
        reference.update({'id': reference.id}));

    debugPrint("sussessful id updated 2");
    addNote(data);
    // fetchNotes();
    notifyListeners();
    Navigator.of(context).pop();
    notifyListeners();
  }

  void updateRecord(BuildContext context, String? title, String content,
      String id, String color, String uid) async {
    DocumentReference parentDocRef =
        FirebaseFirestore.instance.collection("users").doc(userID);

    CollectionReference childCollRef = parentDocRef.collection("notes");
    String formatDate = DateFormat('dd/MM/yy').format(date);

    await childCollRef.doc(uid).update(Notes(
            id: id,
            title: title,
            color: color,
            content: content,
            date: formatDate)
        .toJson());
    notifyListeners();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future deleteRecord(String id) async {
    try {
      debugPrint("provider delete");
      DocumentReference parentDocRef =
          FirebaseFirestore.instance.collection("users").doc(userID);

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
