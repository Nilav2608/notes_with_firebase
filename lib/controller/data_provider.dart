
import 'package:flutter/material.dart';

import '../models/note_model.dart';

class NotesDataProvider extends ChangeNotifier {
  List<Notes> _notesList = [];

  List<Notes> get notes => _notesList;
  getNote() {
    return _notesList;
  }

  addNote(Notes notes) {
    _notesList.add(notes);
    notifyListeners();
  }
}
