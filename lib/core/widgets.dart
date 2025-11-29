import 'package:flutter/material.dart';

class Widgets {
  Center buildLoading() {
    return Center(child: CircularProgressIndicator(color: Colors.deepOrange));
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackBar(
    BuildContext context,
    String message,
    Color color,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: color,
      ),
    );
  }
}
