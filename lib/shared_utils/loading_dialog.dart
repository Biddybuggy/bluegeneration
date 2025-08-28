import 'package:flutter/material.dart';

Future<void> showLoadingDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false, // User cannot dismiss by tapping outside
    builder: (BuildContext context) {
      return const Dialog(
        backgroundColor: Colors.transparent,
        elevation: 10,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop(); // Close the dialog
}
