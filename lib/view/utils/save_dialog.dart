import 'package:flutter/material.dart';
import 'package:notes_with_firebase/view/utils/materal_buton.dart';

class SaveDialog extends StatelessWidget {
  const SaveDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF252525),
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Icon(Icons.info, color: Color(0xFF606060)),
            // const SizedBox(
            //   height: 20,
            // ),
            const Text(
              "Save changes ?",
              style: TextStyle(color: Color(0xFFCFCFCF), fontSize: 23),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(
                    onPressed: () => Navigator.of(context).pop(),
                    color: const Color(0xFFFF0000),
                    text: "Discard"),
                Button(
                    onPressed: () {},
                    color: const Color(0xFF30BE71),
                    text: "Save")
              ],
            )
          ],
        ),
      ),
    );
  }
}
