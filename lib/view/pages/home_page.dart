import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_with_firebase/controller/auth_service.dart';
import 'package:notes_with_firebase/models/note_model.dart';
import 'package:notes_with_firebase/view/pages/add_note_page.dart';
import 'package:notes_with_firebase/view/pages/edit_note.dart';
import 'package:notes_with_firebase/view/utils/tile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color bgColor = const Color(0x00252525);

  final List<int> tileColors = [
    0xFFFD99FF,
    0xFFFF9E9E,
    0xFF91F48F,
    0xFFFFF599,
    0xFF9EFFFF,
    0xFFB69CFF,
  ];

  List<Notes> notesList = [];
  //   String? userId = FirebaseAuth.instance.currentUser?.uid;

  // DocumentReference parentDocRef =
  //         FirebaseFirestore.instance.collection("users").doc(userId);

  //     CollectionReference childCollRef = parentDocRef.collection("notes");
  var ref = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("notes");

  // @override
  // void initState() {
  //   fetchRecords();
  //   debugPrint("data fetched");
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .collection("notes")
  //       .snapshots()
  //       .listen((records) {
  //     mapRecords(records);
  //   });
  //   super.initState();
  // }

  // fetchRecords() async {
  //   var records = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .collection("notes")
  //       .get();
  //   // var records = await ref.get();
  //   await mapRecords(records);
  // }

  // mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
  //   var list = records.docs
  //       .map((item) => Notes(
  //           title: item["title"], content: item["content"], date: item["date"]))
  //       .toList();
  //   setState(() {
  //     notesList = list;
  //   });
  //   print("length ${notesList.length}");
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              backgroundColor: bgColor,
              elevation: 0,
              title: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Notes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () => AuthService().signOut(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 59, 59, 59),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(
                          Icons.logout_rounded,
                          size: 24,
                        )),
                  ),
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
                    )).then((value) {
                  setState(() {});
                });
              },
              backgroundColor: const Color.fromARGB(255, 59, 59, 59),
              elevation: 10,
              child: const Icon(
                Icons.add_rounded,
                size: 48,
              ),
            ),
            body: FutureBuilder(
              future: ref.get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/body.png"),
                        const Text(
                          "Create Your first note !",
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        )
                      ],
                    );
                  }
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var random = Random();
                    var bg = tileColors[random.nextInt(6)];
                    Map data = snapshot.data!.docs[index].data();
                    // var date = (data["date"] as Timestamp).toDate();
                    var date = DateTime.parse(data["date"]);
                    String formattedDate = DateFormat('MMM d').format(date);
                    return InkWell(
                      child: TodoTile(
                        text: data["title"],
                        formattedTime: formattedDate,
                        colorRandom: bg,
                      ),
                    );
                  },
                );
              },
            )));
  }
}
