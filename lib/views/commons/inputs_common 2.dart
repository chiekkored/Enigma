import 'package:flutter/material.dart';

import 'package:enigma/utilities/constants/themes_constant.dart';

/// SECTION CustomAuthInput
/// Custom Inputs with Icons
/// Commonly used for authentication pages
///
/// @param obscureText boolean that obscures the text input
/// @param icon accepts IconData
/// @param hintText accepts string for hint text prop
/// @param controller is a controller for an editable text field
/// @param textInputAction action the user requested for the text input field to perform
/// @param keyboardType a text validator for inputs
///
/// @author Thomas Rey B Barcenas
class CustomAuthInput extends StatelessWidget {
  final bool obscureText;
  final IconData icon;
  final IconData? iconEnd;
  final String hintText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  const CustomAuthInput({
    Key? key,
    required this.obscureText,
    required this.icon,
    required this.hintText,
    required this.controller,
    required this.textInputAction,
    required this.keyboardType,
    this.iconEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: const BorderSide(
                  color: CColors.secondaryTextLightColor,
                  width: 1.0,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: const BorderSide(color: CColors.buttonLightColor)),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 26.0, right: 12.0),
              child: Icon(
                icon,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 26.0),
              child: Icon(
                iconEnd,
              ),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                fontFamily: "Inter")));
  }
}

/// !SECTION
