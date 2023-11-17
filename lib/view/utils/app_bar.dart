
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  // final Color bgColor;
  final VoidCallback signOut;
  const MyAppBar({
    // required this.bgColor,
    required this.signOut,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 0,
            title:  Padding(
              padding: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Notes",

                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold, fontSize: 32),
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
                          // color: const Color.fromARGB(255, 59, 59, 59),
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(15)),
                      child:  Icon(
                        Icons.logout_rounded,
                        color: Theme.of(context).colorScheme.secondary,
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
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(15)),
                    child:  Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.secondary,
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