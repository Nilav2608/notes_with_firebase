import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../models/note_model.dart';

class TodoTile extends StatelessWidget {
  // final String text;
  // final String formattedTime;
  final Notes notes;
  final int colorRandom;
  final Function(BuildContext)? deleteNote;
  const TodoTile({
    super.key,
    required this.deleteNote,
    // required this.formattedTime,
    required this.notes,
    required this.colorRandom,
    // required this.text
  });

  @override
  Widget build(BuildContext context) {
    // var formattedDateString = DateFormat('MMM d').format(formattedTime);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteNote,
            icon: Icons.delete,
            backgroundColor: const Color(0xFFFF0000),
            borderRadius: BorderRadius.circular(10),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 100,
          decoration: BoxDecoration(
              color: Color(colorRandom),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            // padding: const EdgeInsets.all(8.0),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // padding: const EdgeInsets.only(bottom: 2),
                height: 65,
                child: Text(
                  "${notes.title}",
                  style: const TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${notes.date}",
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontFamily: "lato",
                      color: Color.fromARGB(109, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
