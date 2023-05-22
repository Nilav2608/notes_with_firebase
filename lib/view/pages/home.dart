import 'package:flutter/material.dart';
import 'package:notes_with_firebase/view/pages/add_note.dart';
import 'package:notes_with_firebase/view/utils/tile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool init = false;
  Color bgColor = const Color(0x00252525);

  final List<int> tileColors = [
    0xFFFD99FF,
    0xFFFF9E9E,
    0xFF91F48F,
    0xFFFFF599,
    0xFF9EFFFF,
    0xFFB69CFF,
    0xFF9C9C9C
  ];

  @override
  void initState() {
    init = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            const SizedBox(
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
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNote(),
                ));
          },
          backgroundColor: const Color.fromARGB(255, 59, 59, 59),
          elevation: 10,
          child: const Icon(
            Icons.add_rounded,
            size: 48,
          ),
        ),
        body: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            // int color = tileColors[index];
            return TodoTile(
              text: "test",
              colorRandom: tileColors[index],
            );
          },
        ),
      ),
    );
  }
}
