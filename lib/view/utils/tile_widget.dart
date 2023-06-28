import 'package:flutter/material.dart';

import '../../models/note_model.dart';

class TodoTile extends StatelessWidget {
  // final String text;
  // final String formattedTime;
  final Notes notes;
  final int colorRandom;
  // final VoidCallback onTap;
  const TodoTile({
    super.key,
    // required this.onTap,
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
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 5),
        height: 100,
        decoration: BoxDecoration(
            color: Color(colorRandom), borderRadius: BorderRadius.circular(10)),
        child: Column(
          // padding: const EdgeInsets.all(8.0),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${notes.title}",
              style: const TextStyle(color: Colors.black, fontSize: 24),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${notes.date}",
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontFamily: "lato",
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
