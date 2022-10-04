import 'dart:io';

import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// SECTION showCustomAlertDialog
/// Alert Dialog
///
/// @param context A handle to the location of a widget in the widget tree.
/// @param title Alert dialog title
/// @param content Alert dialog content body
/// @param buttonText Text inside the button
/// @param page Navigator push to page
///
/// @author Thomas Rey B Barcenas
void showCustomAlertDialog(BuildContext context, String title, String content,
    String buttonText, dynamic page) {
  if (Platform.isIOS) {
    // NOTE iOS show dialog
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: CustomTextBody2Centered(text: content),
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
    // NOTE Android show dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: CustomTextBody2Centered(text: content),
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

/// SECTION showCustomModal
/// Modal alert dialog
///
/// @param context A handle to the location of a widget in the widget tree.
///
/// @author Thomas Rey B Barcenas
void showCustomModal(BuildContext context,
    {required IconData icon,
    required Color color,
    required Widget widget,
    Widget? button}) {
  if (Platform.isIOS) {
    // NOTE iOS show dialog
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(40.0),
              decoration: BoxDecoration(
                color: CColors.trueWhite,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22.0),
                    child: Icon(icon, size: 64.0, color: color),
                  ),
                  widget,
                  button ?? Container(),
                ],
              ),
            ),
          );
        });
  } else {
    // NOTE Android show dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(40.0),
            decoration: BoxDecoration(
              color: CColors.trueWhite,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 22.0),
                  child: Icon(icon, size: 64.0, color: color),
                ),
                widget,
                button ?? Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// !SECTION
