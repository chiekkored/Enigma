import 'dart:io';

import 'package:enigma/views/commons/texts_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// SECTION showCustomAlertDialog
/// Alert Dialog
///
/// @param context Screen context to pass
/// @param title Alert dialog title
/// @param content Alert dialog content body
/// @param buttonText Text inside the button
/// @param page Navigator push to page
///
/// @author Thomas Rey B Barcenas
void showCustomAlertDialog(BuildContext context, String title, String content,
    String buttonText, dynamic page) {
  if (Platform.isIOS) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: CustomTextBody2(text: content),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(buttonText),
                onPressed: () {
                  if (page != null) {
                    // ignore: unnecessary_statements
                    page;
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: CustomTextBody2(text: content),
            actions: <Widget>[
              TextButton(
                child: Text(buttonText),
                onPressed: () {
                  if (page != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => page),
                    );
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

/// !SECTION

/// SECTION showCustomModalBottomSheet
/// Alert Dialog
///
/// @param context Screen context to pass
/// @param (nullable) isDismissible Alert dialog title
/// @param (nullable) isScrollControlled Alert dialog content body
/// @param child Text inside the button
///
/// @author Chiekko Red
Future<void> showCustomModalBottomSheet(
    {required BuildContext context,
    bool? isDismissible,
    bool? isScrollControlled,
    required Widget child}) {
  return showModalBottomSheet(
      context: context,
      isDismissible: isDismissible ?? false,
      isScrollControlled: isScrollControlled ?? true,
      builder: ((context) => CupertinoPopupSurface(
            child: Material(child: child),
          )));
}

/// !SECTION
