import 'package:flutter/material.dart';

/// Custom Color constants
class CColors {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _scaffoldLightBackgroundColor,
    backgroundColor: _containerLightBackgroundColor,
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(_buttonLightColor))),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: _black),
      button: TextStyle(color: _white),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _scaffoldDarkBackgroundColor,
    backgroundColor: _containerDarkBackgroundColor,
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(_buttonDarkColor))),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: _white),
      button: TextStyle(color: _white),
    ),
  );

  // Common colors constants
  static const _white = Color.fromRGBO(223, 223, 223, 1);
  static const _black = Color.fromRGBO(19, 19, 19, 1);

  // Light Theme constants
  static const _scaffoldLightBackgroundColor = Color.fromRGBO(169, 169, 169, 1);
  static const _containerLightBackgroundColor =
      Color.fromARGB(255, 255, 255, 255);
  static const _buttonLightColor = Color.fromRGBO(25, 124, 40, 1);

  // Dark Theme constants
  static const _scaffoldDarkBackgroundColor = Color.fromARGB(255, 29, 29, 29);
  static const _containerDarkBackgroundColor = Color.fromARGB(255, 45, 45, 45);
  static const _buttonDarkColor = Color.fromRGBO(25, 124, 40, 1);
}
