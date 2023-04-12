import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tara/utilities/constants/themes_constant.dart';
import 'package:tara/views/commons/texts_common.dart';

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
                    page;
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
void showCustomAlertOptionsDialog(
    BuildContext context,
    String title,
    String content,
    String buttonTextLeft,
    dynamic pageLeft,
    String buttonTextRight,
    dynamic pageRight) {
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
                child: Text(buttonTextLeft),
                onPressed: () {
                  if (pageLeft != null) {
                    // ignore: unnecessary_statements

                    pageLeft;
                  }
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text(buttonTextRight),
                onPressed: () {
                  if (pageRight != null) {
                    pageRight;
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
                child: Text(buttonTextLeft),
                onPressed: () {
                  if (pageLeft != null) {
                    pageLeft;
                  }
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(buttonTextRight),
                onPressed: () {
                  if (pageRight != null) {
                    pageRight;
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
    {IconData? icon, Color? color, required Widget widget, Widget? button}) {
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
                children: [
                  icon != null
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 22.0),
                          child: Icon(icon, size: 64.0, color: color),
                        )
                      : Container(),
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
              children: [
                icon != null
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 22.0),
                        child: Icon(icon, size: 64.0, color: color),
                      )
                    : Container(),
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

/// SECTION showCustomModal
/// Modal alert dialog
///
/// @param context A handle to the location of a widget in the widget tree.
///
/// @author Thomas Rey B Barcenas
void showCustomModalWithNoIcon(BuildContext context,
    {required Widget widget, bool? dismissable, bool withPadding = true}) {
  if (Platform.isIOS) {
    // NOTE iOS show dialog
    showCupertinoDialog(
        barrierDismissible: dismissable ?? false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: withPadding ? const EdgeInsets.all(40.0) : null,
              decoration: BoxDecoration(
                color: CColors.trueWhite,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: widget,
            ),
          );
        });
  } else {
    // NOTE Android show dialog
    showDialog(
      barrierDismissible: dismissable ?? false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: withPadding ? const EdgeInsets.all(40.0) : null,
            decoration: BoxDecoration(
              color: CColors.trueWhite,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: widget,
          ),
        );
      },
    );
  }
}

/// !SECTION
