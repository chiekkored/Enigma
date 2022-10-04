// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:group_button/group_button.dart';

/// SECTION CustomPrimaryButton
/// Primary(#5A189A) Button
///
/// @param text Text inside the button
/// @param doOnPressed Function when user clicks
///
/// @author Thomas Rey B Barcenas
class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback doOnPressed;
  const CustomPrimaryButton({
    Key? key,
    required this.text,
    required this.doOnPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: doOnPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        child: Container(
            // width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 19.0),
            child: Center(
              child: CustomTextHeader3(
                text: text,
                color: CColors.white,
              ),
            )));
  }
}

/// !SECTION

/// SECTION CustomPrimaryButtonWithLoading
/// Primary(#5A189A) Button
///
/// @param text Text inside the button
/// @param doOnPressed Function when user clicks
///
/// @author Thomas Rey B Barcenas
class CustomPrimaryButtonWithLoading extends StatelessWidget {
  final String text;
  final VoidCallback doOnPressed;
  final bool loading;
  const CustomPrimaryButtonWithLoading({
    Key? key,
    required this.text,
    required this.doOnPressed,
    required this.loading,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: loading ? null : doOnPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: loading
              ? CColors.secondaryButtonLightColor
              : CColors.buttonLightColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        child: Container(
            // width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 19.0),
            child: Center(
              child: loading
                  ? SizedBox.square(
                      dimension: 18.0,
                      child: Platform.isIOS
                          ? const CupertinoActivityIndicator(
                              color: CColors.secondaryColor)
                          : const CircularProgressIndicator(
                              color: CColors.secondaryColor))
                  : CustomTextHeader3(
                      text: text,
                      color: CColors.white,
                    ),
            )));
  }
}

/// !SECTION

/// SECTION CustomPrimaryButtonSmall
/// Primary(#5A189A) Button
///
/// @param text Text inside the button
/// @param doOnPressed Function when user clicks
///
/// @author Thomas Rey B Barcenas
class CustomPrimaryButtonSmall extends StatelessWidget {
  final String text;
  final VoidCallback doOnPressed;
  const CustomPrimaryButtonSmall({
    Key? key,
    required this.text,
    required this.doOnPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: doOnPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        child: Container(
            // width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: CustomTextHeader3(
                text: text,
                color: CColors.white,
              ),
            )));
  }
}

/// !SECTION

/// SECTION CustomSecondaryButton
/// Secondary(#F4F5F7) Button
///
/// @param text Text inside the button
/// @param doOnPressed Function when user clicks
///
/// @author Thomas Rey B Barcenas
class CustomSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? doOnPressed;
  const CustomSecondaryButton({
    Key? key,
    required this.text,
    this.doOnPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: doOnPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        child: Container(
            // width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.symmetric(vertical: 19.0, horizontal: 8.0),
            child: Center(
              child: CustomTextHeader3(
                text: text,
              ),
            )));
  }
}

/// !SECTION

/// SECTION CustomDangerButton
/// Danger(#E53F71) Button
///
/// @param text Text inside the button
/// @param doOnPressed Function when user clicks
///
/// @author Thomas Rey B Barcenas
class CustomDangerButton extends StatelessWidget {
  final String text;
  final VoidCallback doOnPressed;
  const CustomDangerButton({
    Key? key,
    required this.text,
    required this.doOnPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: doOnPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 19.0),
            child: Center(
              child: CustomTextHeader3(
                text: text,
                color: CColors.white,
              ),
            )));
  }
}

/// !SECTION

/// SECTION CustomDisabledButton
/// Disabled(#F4F5F7) Button
///
/// @param text Text inside the button
/// @param doOnPressed Function when user clicks
///
/// @author Thomas Rey B Barcenas
class CustomDisabledButton extends StatelessWidget {
  final String text;
  final VoidCallback doOnPressed;
  const CustomDisabledButton({
    Key? key,
    required this.text,
    required this.doOnPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: doOnPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 19.0),
            child: Center(
              child: CustomTextHeader3(
                text: text,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            )));
  }
}

/// !SECTION

/// SECTION CustomTextButton
/// Text Button
///
/// @param child Widget inside the button
/// @param onPressed Function when user clicks
///
/// @author Chiekko Red
class CustomTextButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const CustomTextButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide.none,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

/// !SECTION

/// SECTION customGroupButtonOptions
/// Custom Group Button Options
///
/// @author Chiekko Red
GroupButtonOptions customGroupButtonOptions() {
  return GroupButtonOptions(
    direction: Axis.horizontal,
    selectedTextStyle: customRadioButtonTextStyle(),
    unselectedTextStyle: customRadioButtonTextStyle(),
    selectedColor: CColors.buttonLightColor,
    unselectedColor: CColors.secondaryTextLightColor,
    borderRadius: BorderRadius.circular(32.0),
    spacing: 10,
    runSpacing: 20,
    elevation: 0.0,
    selectedShadow: [],
    unselectedShadow: [],
    // textPadding: const EdgeInsets.symmetric(
    //   vertical: 19.0,
    //   horizontal: 12.0,
    // ),
    mainGroupAlignment: MainGroupAlignment.start,
    alignment: Alignment.centerLeft,
  );
}

GroupButtonOptions customGroupButtonOptionsFromModal() {
  return GroupButtonOptions(
    selectedTextStyle: customRadioButtonTextStyle(),
    unselectedTextStyle: customRadioButtonTextStyle(),
    selectedColor: CColors.buttonLightColor,
    unselectedColor: CColors.secondaryTextLightColor,
    borderRadius: BorderRadius.circular(32.0),
    spacing: 10,
    runSpacing: 20,
    elevation: 0.0,
    selectedShadow: [],
    unselectedShadow: [],
    // textPadding: const EdgeInsets.symmetric(
    //   vertical: 19.0,
    //   horizontal: 12.0,
    // ),
    mainGroupAlignment: MainGroupAlignment.center,
    alignment: Alignment.centerLeft,
  );
}

/// SECTION Custom Radio Button TextStyle
TextStyle customRadioButtonTextStyle() {
  return const TextStyle(
      color: CColors.trueWhite,
      fontSize: 15.0,
      fontWeight: FontWeight.w700,
      fontFamily: "Inter");
}
/// !SECTION
/// !SECTION