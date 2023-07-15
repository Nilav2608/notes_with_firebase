import 'package:flutter/material.dart';

import '../../models/note_model.dart';

class EditNote extends StatefulWidget {
  final Notes note;

  const EditNote({required this.note, super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  bool enableEdit = false;

  String? oldTile;

  String? oldDescription;

  @override
  Widget build(BuildContext context) {
    Color bgColor = const Color(0x00252525);

    return Scaffold(
      backgroundColor: bgColor,
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
                    color: const Color.fromARGB(255, 59, 59, 59),
                    borderRadius: BorderRadius.circular(15)),
                child: const Icon(
                  Icons.arrow_back,
                  size: 24,
                )),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                enableEdit = !enableEdit;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 59, 59, 59),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Icon(
                    Icons.edit,
                    size: 24,
                  )),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //* Title

              Expanded(
                flex: 1,
                child: TextFormField(
                  // minLines: 1,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        color: Color(0xFF9A9A9A),
                        fontSize: 48,
                      )),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 48),
                  enabled: enableEdit,
                  initialValue: widget.note.title,
                  onChanged: (value) {
                    oldTile = value;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              //* Type Something.....

              Expanded(
                flex: 2,
                child: TextFormField(
                  // minLines: 1,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type something...',
                      hintStyle: TextStyle(
                        color: Color(0xFF9A9A9A),
                        fontSize: 24,
                      )),
                  style:
                      const TextStyle(color: Color(0xFFFFFFFF), fontSize: 24),
                  enabled: enableEdit,
                  initialValue: widget.note.content,
                  onChanged: (value) {
                    oldDescription = value;
                  },
                ),
              ),
              Visibility(
                visible: enableEdit,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0, right: 30),
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: const Color.fromARGB(255, 59, 59, 59),
                      elevation: 10,
                      child: const Icon(
                        Icons.save_rounded,
                        size: 38,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
