import 'package:flutter/material.dart';

/// Custom Color constants
class CColors {
  /// SECTION lightTheme
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: scaffoldLightBackgroundColor,
      backgroundColor: containerLightBackgroundColor,

      /// SECTION outlinedButtonTheme
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonLightColor))),

      /// !SECTION
      /// SECTION textTheme
      textTheme: const TextTheme(
        bodyText1: TextStyle(
            color: primaryTextLightColor,
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter"),
        bodyText2: TextStyle(
            color: primaryTextLightColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter"),
        subtitle1: TextStyle(
            color: primaryTextLightColor,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter"),
        headline1: TextStyle(
            color: primaryTextLightColor,
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter"),
        headline2: TextStyle(
            color: primaryTextLightColor,
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter"),
        headline3: TextStyle(
            color: primaryTextLightColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter"),
      ),

      /// !SECTION
      /// SECTION colorScheme
      colorScheme: ColorScheme.fromSwatch().copyWith(
        // Main Colors
        primary: buttonLightColor,
        secondary: secondaryColor,
        outline: strokeColor,
        error: dangerColor,
        surface: onlineColor,
        // Container Colors
        primaryContainer: buttonLightColor,
        secondaryContainer: secondaryButtonLightColor,
        errorContainer: dangerColor,
        // Text Colors
        tertiary: secondaryTextLightColor,
      )

      /// !SECTION
      );

  /// !SECTION

  /// SECTION darkTheme
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: scaffoldDarkBackgroundColor,
    backgroundColor: containerDarkBackgroundColor,

    /// SECTION outlinedButtonTheme
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonDarkColor))),

    /// !SECTION
    /// SECTION textTheme
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: white),
      button: TextStyle(color: white),
    ),

    /// !SECTION
  );

  /// !SECTION

  /// ANCHOR Common colors constants
  static const white = Color.fromRGBO(223, 223, 223, 1);
  static const trueWhite = Color.fromARGB(255, 255, 255, 255);
  static const black = Color.fromRGBO(19, 19, 19, 1);

  /// ANCHOR Light Theme constants
  static const scaffoldLightBackgroundColor = Color.fromRGBO(169, 169, 169, 1);
  static const containerLightBackgroundColor =
      Color.fromARGB(255, 255, 255, 255);
  static const buttonLightColor = Color(0xFF5A189A);
  static const secondaryButtonLightColor = Color(0xFFF4F5F7);
  static const primaryTextLightColor = Color(0xFF2E3E5C);
  static const secondaryTextLightColor = Color(0xFF9FA5C0);
  static const secondaryColor = Color(0xFFFF8500);
  static const dangerColor = Color(0xFFE53F71);
  static const strokeColor = Color(0xFFD0DBEA);
  static const onlineColor = Color(0xFF34C300);

  /// ANCHOR Dark Theme constants
  static const scaffoldDarkBackgroundColor = Color.fromARGB(255, 29, 29, 29);
  static const containerDarkBackgroundColor = Color.fromARGB(255, 45, 45, 45);
  static const buttonDarkColor = Color.fromRGBO(25, 124, 40, 1);
}
