import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  final DocumentReference ref;
  final Map data;
  // final String date;

  const EditNote(
      {required this.ref,
      required this.data,
      // required this.title,
      super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  bool enableEdit = false;
  String? title;
  String? content;
  @override
  Widget build(BuildContext context) {
    Color bgColor = const Color(0x00252525);

    var key = GlobalKey<FormState>();
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
      body: Form(
        key: key,
        child: Padding(
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
                      color: Color.fromARGB(255, 57, 55, 55), fontSize: 48),
                  enabled: enableEdit,
                  initialValue: widget.data["title"],
                  onChanged: (value) {
                    title = value;
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
                  initialValue: widget.data["content"],
                  onChanged: (value) {
                    content = value;
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
                      onPressed: () {
                        update();
                      },
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
      ),
    );
  }

  update() async {
    // await widget.ref.update(
    //     Notes(title: title, content: content, date: DateTime.now().toString())
    //         .toJson());
    Navigator.of(context).pop();
  }
}
