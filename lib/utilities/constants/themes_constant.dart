import 'package:flutter/material.dart';

/// Custom Color constants
class CColors {
  /// SECTION lightTheme
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: _scaffoldLightBackgroundColor,
      backgroundColor: _containerLightBackgroundColor,

      /// SECTION outlinedButtonTheme
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(_buttonLightColor))),

      /// !SECTION
      /// SECTION textTheme
      textTheme: const TextTheme(
        bodyText1: TextStyle(
            color: _primaryTextLightColor,
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter"),
        bodyText2: TextStyle(
            color: _primaryTextLightColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter"),
        subtitle1: TextStyle(
            color: _primaryTextLightColor,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter"),
        headline1: TextStyle(
            color: _primaryTextLightColor,
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter"),
        headline2: TextStyle(
            color: _primaryTextLightColor,
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter"),
        headline3: TextStyle(
            color: _primaryTextLightColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter"),
      ),

      /// !SECTION
      /// SECTION colorScheme
      colorScheme: ColorScheme.fromSwatch().copyWith(
        // Main Colors
        primary: _buttonLightColor,
        secondary: _secondaryColor,
        outline: _strokeColor,
        error: _dangerColor,
        surface: _onlineColor,
        // Container Colors
        primaryContainer: _buttonLightColor,
        secondaryContainer: _secondaryButtonLightColor,
        errorContainer: _dangerColor,
        // Text Colors
        tertiary: _secondaryTextLightColor,
      )

      /// !SECTION
      );

  /// !SECTION

  /// SECTION darkTheme
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _scaffoldDarkBackgroundColor,
    backgroundColor: _containerDarkBackgroundColor,

    /// SECTION outlinedButtonTheme
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(_buttonDarkColor))),

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
  static const _black = Color.fromRGBO(19, 19, 19, 1);

  /// ANCHOR Light Theme constants
  static const _scaffoldLightBackgroundColor = Color.fromRGBO(169, 169, 169, 1);
  static const _containerLightBackgroundColor =
      Color.fromARGB(255, 255, 255, 255);
  static const _buttonLightColor = Color(0xFF5A189A);
  static const _secondaryButtonLightColor = Color(0xFFF4F5F7);
  static const _primaryTextLightColor = Color(0xFF2E3E5C);
  static const _secondaryTextLightColor = Color(0xFF9FA5C0);
  static const _secondaryColor = Color(0xFFFF8500);
  static const _dangerColor = Color(0xFFE53F71);
  static const _strokeColor = Color(0xFFD0DBEA);
  static const _onlineColor = Color(0xFF34C300);

  /// ANCHOR Dark Theme constants
  static const _scaffoldDarkBackgroundColor = Color.fromARGB(255, 29, 29, 29);
  static const _containerDarkBackgroundColor = Color.fromARGB(255, 45, 45, 45);
  static const _buttonDarkColor = Color.fromRGBO(25, 124, 40, 1);
}
