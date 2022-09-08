import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:flutter/material.dart';

/// SECTION CustomTextTitle1
/// Custom Text (Header)
///
/// @param text Text inside the Text() widget
/// @param color Color of the text
///
/// @author Chiekko Red
class CustomTextTitle1 extends StatelessWidget {
  final String text;
  final Color? color;
  const CustomTextTitle1({Key? key, required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color ?? CColors.primaryTextLightColor,
          fontSize: 32.0,
          fontWeight: FontWeight.w700),
    );
  }
}

/// SECTION CustomTextBodyText1
/// Custom Text (Header)
///
/// @param text Text inside the Text() widget
/// @param color Color of the text
///
/// @author Chiekko Red
class CustomTextBodyText1 extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  const CustomTextBodyText1(
      {Key? key, required this.text, this.color, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.left,
      style: TextStyle(
          color: color ?? CColors.primaryTextLightColor,
          fontSize: 20.0,
          fontWeight: FontWeight.w700),
    );
  }
}

/// SECTION CustomTextSubtitle2
/// Custom Text (Header)
///
/// @param text Text inside the Text() widget
/// @param color Color of the text
///
/// @author Chiekko Red
class CustomTextSubtitle2 extends StatelessWidget {
  final String text;
  final Color? color;
  const CustomTextSubtitle2({Key? key, required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color ?? CColors.primaryTextLightColor,
          fontSize: 6.0,
          fontWeight: FontWeight.w500),
    );
  }
}

/// !SECTION

/// SECTION CustomTextHeader1
/// Custom Text (Header)
///
/// @param text Text inside the Text() widget
/// @param color Color of the text
///
/// @author Thomas Rey B Barcenas
class CustomTextHeader1 extends StatelessWidget {
  final String text;
  final Color? color;
  const CustomTextHeader1({Key? key, required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: color == null
          ? Theme.of(context).textTheme.headline1
          : TextStyle(
              color: color, fontSize: 22.0, fontWeight: FontWeight.w700),
    );
  }
}

/// !SECTION

/// SECTION CustomTextHeader2
/// Custom Text (Header)
///
/// @param text Text inside the Text() widget
/// @param color Color of the text
///
/// @author Thomas Rey B Barcenas
class CustomTextHeader2 extends StatelessWidget {
  final String text;
  final Color? color;
  const CustomTextHeader2({Key? key, required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: color == null
          ? Theme.of(context).textTheme.headline2
          : TextStyle(
              color: color, fontSize: 17.0, fontWeight: FontWeight.w700),
    );
  }
}

/// !SECTION

/// SECTION CustomTextHeader3
/// Custom Text (Header)
///
/// @param text Text inside the Text() widget
/// @param color Color of the text
///
/// @author Thomas Rey B Barcenas
class CustomTextHeader3 extends StatelessWidget {
  final String text;
  final Color? color;
  const CustomTextHeader3({Key? key, required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: color == null
          ? Theme.of(context).textTheme.headline3
          : TextStyle(
              color: color, fontSize: 15.0, fontWeight: FontWeight.w700),
    );
  }
}

/// !SECTION

/// SECTION CustomTextBody1
/// Custom Text (Body)
///
/// @param text Text inside the Text() widget
/// @param color Color of the text
///
/// @author Thomas Rey B Barcenas
class CustomTextBody1 extends StatelessWidget {
  final String text;
  final Color? color;
  const CustomTextBody1({Key? key, required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: color == null
          ? Theme.of(context).textTheme.bodyText1
          : TextStyle(
              color: color, fontSize: 17.0, fontWeight: FontWeight.w500),
    );
  }
}

/// !SECTION

/// SECTION CustomTextBody2
/// Custom Text (Body)
///
/// @param text Text inside the Text() widget
/// @param color Color of the text
///
/// @author Thomas Rey B Barcenas
class CustomTextBody2 extends StatelessWidget {
  final String text;
  final Color? color;
  const CustomTextBody2({Key? key, required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: color == null
          ? Theme.of(context).textTheme.bodyText2
          : TextStyle(
              color: color, fontSize: 15.0, fontWeight: FontWeight.w500),
    );
  }
}

/// !SECTION

/// SECTION CustomTextSubtitle1
/// Custom Text (Subtitle)
///
/// @param text Text inside the Text() widget
/// @param color Color of the text
///
/// @author Thomas Rey B Barcenas
class CustomTextSubtitle1 extends StatelessWidget {
  final String text;
  final Color? color;
  const CustomTextSubtitle1({Key? key, required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: color == null
          ? Theme.of(context).textTheme.subtitle1
          : TextStyle(
              color: color, fontSize: 12.0, fontWeight: FontWeight.w500),
    );
  }
}
/// !SECTION