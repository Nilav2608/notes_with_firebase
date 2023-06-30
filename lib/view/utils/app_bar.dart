
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final Color bgColor;
  final VoidCallback signOut;
  const MyAppBar({
    required this.bgColor,
    required this.signOut,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                onTap:  signOut,
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
          );
  }
}