import 'package:flutter/material.dart';



class Dialogs{

  circularProgress(BuildContext context){
      showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}