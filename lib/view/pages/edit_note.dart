import 'package:flutter/material.dart';
import 'package:notes_with_firebase/controller/data_provider.dart';
import 'package:provider/provider.dart';

import '../../models/note_model.dart';

class EditNote extends StatefulWidget {
  final Notes note;

  const EditNote({required this.note, super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  bool enableEdit = false;

  @override
  Widget build(BuildContext context) {
    Color bgColor = Theme.of(context).colorScheme.background;
    var dataProvider = Provider.of<NotesDataProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: bgColor,
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
          GestureDetector(
            onTap: () {
              debugPrint("clicked");
              setState(() {
                enableEdit = !enableEdit;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(15)),
                  child: Icon(
                    Icons.edit,
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
      body: Stack(children: [
        SingleChildScrollView(
          // controller: controller,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //* Title

                TextFormField(
                  minLines: 1,
                  maxLines: 7,
                  // expands: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 48,
                      )),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 48),
                  enabled: enableEdit,
                  //we use widgit keyword to access the current vaule od notes.title
                  initialValue: widget.note.title,
                  onChanged: (value) {
                    widget.note.title = value;
                  },
                ),

                const SizedBox(
                  height: 5,
                ),

                //* Type Something.....

                TextFormField(
                  minLines: 1,
                  maxLines: 100,
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
                  enabled: enableEdit,
                  initialValue: widget.note.content,
                  onChanged: (value) {
                    widget.note.content = value;
                  },
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: enableEdit,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0, right: 30),
              child: FloatingActionButton(
                onPressed: () {
                  dataProvider.updateRecord(
                      context,
                      widget.note.title ?? '',
                      widget.note.content ?? "",
                      widget.note.id ?? '',
                      widget.note.color!,
                      widget.note.id!);
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                elevation: 10,
                child: Icon(
                  Icons.save_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 38,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
