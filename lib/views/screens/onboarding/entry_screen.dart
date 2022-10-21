import 'package:flutter/material.dart';

import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/onboarding/onboarding_screen.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (() => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const OnboardingScreen()))),
        child: Container(
          color: CColors.trueWhite,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CustomTextTitle1(
                    text: "Hi!",
                    color: CColors.secondaryColor,
                  ),
                  CustomTextTitle1(
                    text: "Welcome to Tara",
                    color: CColors.secondaryColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextBody1NoEllipsis(
                    text: "Click, Swipe and Choose peers in your interest!",
                    color: CColors.secondaryTextLightColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
