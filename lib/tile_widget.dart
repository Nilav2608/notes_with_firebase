import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String text;
  final int colorRandom;
  const TodoTile({super.key, required this.colorRandom, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              color: Color(colorRandom),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
