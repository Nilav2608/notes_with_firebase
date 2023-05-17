import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color bgColor = const Color(0x252525);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Notes",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 59, 59, 59),
                    borderRadius: BorderRadius.circular(15)),
                child: const Icon(
                  Icons.search_rounded,
                  size: 24,
                )),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 59, 59, 59),
                    borderRadius: BorderRadius.circular(15)),
                child: const Icon(
                  Icons.info_outline,
                  size: 24,
                )),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
