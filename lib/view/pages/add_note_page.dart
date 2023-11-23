import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_with_firebase/controller/data_provider.dart';

import 'package:provider/provider.dart';

import '../utils/dialogs.dart';

// ignore: must_be_immutable
class AddNote extends StatelessWidget {
  AddNote({super.key});

  String? userId = FirebaseAuth.instance.currentUser?.uid;
  String? title;
  String? content;
  var dialog = Dialogs();
  // Color bgColor = Theme.of(context).colorScheme.background;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NotesDataProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(15)),
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 24,
                )),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(15)),
                child: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 24,
                )),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              try {
                if (title == null) {
                  Navigator.pop(context);
                } else {
                  provider.add(context, title, content);
                }
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            }, // dialog.saveDialog(context, add),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(15)),
                  child: Icon(
                    Icons.save_sharp,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 24,
                  )),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //* Title

              TextField(
                minLines: 1,
                autofocus: true,
                onChanged: (value) => title = value,
                maxLines: 7,
                // expands: true,
                  enableInteractiveSelection: true,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color: Color(0xFF9A9A9A),
                      fontSize: 48,
                    )),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 48),
              ),

              const SizedBox(
                height: 5,
              ),

              //* Type Something.....

              TextField(
                minLines: 1,
                onChanged: (value) => content = value,
                maxLines: 30,
                // expands: true,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type something...',
                    hintStyle: TextStyle(
                      color: Color(0xFF9A9A9A),
                      fontSize: 24,
                    )),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
