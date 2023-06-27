import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static final Dialogs _singleton = Dialogs._internal();

  Dialogs._internal();

  factory Dialogs() {
    return _singleton;
  }

  static Widget questionStartDialogue({required VoidCallback onTap}) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
        Text(
          "Dear user",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text("You need to log in to be able to use this feature."),
      ]),
      actions: [TextButton(onPressed: onTap, child: const Text("Log In"))],
    );
  }
}
