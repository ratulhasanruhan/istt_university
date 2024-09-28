import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showSnack({
  required BuildContext context,
  required ContentType type,
  required String title,
  required String message
}) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    showCloseIcon: false,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 130, left: 10, right: 10),
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: type,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}