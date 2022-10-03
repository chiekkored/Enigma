import 'package:flutter/material.dart';

import 'package:enigma/utilities/constants/themes_constant.dart';

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
      overflow: TextOverflow.ellipsis,
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
      overflow: TextOverflow.ellipsis,
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
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? CColors.primaryTextLightColor,
          fontSize: 10.0,
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
    return Text(text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: color ?? CColors.primaryTextLightColor,
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter"));
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
    return Text(text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: color ?? CColors.primaryTextLightColor,
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter"));
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
    return Text(text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: color ?? CColors.primaryTextLightColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter"));
  }
}

/// !SECTION

/// SECTION CustomTextHeader4
/// Custom Text (Header) centered and without ellipsis
///
/// @param text Text inside the Text() widget
/// @param color Color of the text
///
/// @author Thomas Rey B Barcenas
class CustomTextHeader3Centered extends StatelessWidget {
  final String text;
  final Color? color;
  const CustomTextHeader3Centered({Key? key, required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: color ?? CColors.primaryTextLightColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter"));
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
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? CColors.primaryTextLightColor,
          fontSize: 17.0,
          fontWeight: FontWeight.w500,
          fontFamily: "Inter"),
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
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? CColors.primaryTextLightColor,
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          fontFamily: "Inter"),
    );
  }
}

/// !SECTION

/// SECTION CustomTextBody2Centered
/// Custom Text (Body)
///
/// @param text Text inside the Text() widget
/// @param color Color of the text
///
/// @author Thomas Rey B Barcenas
class CustomTextBody2Centered extends StatelessWidget {
  final String text;
  final Color? color;
  const CustomTextBody2Centered({Key? key, required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: color ?? CColors.primaryTextLightColor,
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          fontFamily: "Inter"),
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
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? CColors.primaryTextLightColor,
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          fontFamily: "Inter"),
    );
  }
}
/// !SECTION
