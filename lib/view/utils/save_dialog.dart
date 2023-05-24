import 'package:flutter/material.dart';

class SaveDialog extends StatelessWidget {
  const SaveDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF252525),
       content: SizedBox(
         height: 230,
         child: Column(
          children: const [

            Icon(Icons.info)
          ],
         ),
       ),
    );
  }
}