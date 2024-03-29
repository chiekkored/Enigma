import 'package:tara/views/screens/onboarding/newProfile/new_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:tara/utilities/constants/themes_constant.dart';
import 'package:tara/views/commons/texts_common.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 1;
  final List<String> _images = [
    "onboarding1.png",
    "onboarding2.png",
    "onboarding3.png"
  ];
  final List<String> _description = [
    "You can add your profile and put your interests or hobbies.",
    "Find your match, tap the profile to share your likes and interests.",
    "We hope it works out! You can start your conversation."
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [CColors.trueWhite, CColors.buttonLightColor])),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: StepProgressIndicator(
                      totalSteps: 3,
                      currentStep: _step,
                      size: 6.0,
                      selectedColor: CColors.secondaryColor,
                      unselectedColor: CColors.secondaryTextLightColor,
                      roundedEdges: const Radius.circular(16.0),
                    ),
                  ),
                  Image.asset("assets/images/${_images[_step - 1]}"),
                  // Text(_images[_step - 1]),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16.0, left: 24.0, right: 24.0),
                    child: CustomTextBody1Centered(
                        color: CColors.trueWhite,
                        text: _description[_step - 1]),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: (() => setState(() {
                    _step > 1 ? _step -= 1 : _step;
                  })),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: (() {
                if (_step != 3) {
                  setState(() {
                    _step < 3 ? _step += 1 : _step;
                  });
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewProfileScreen()));
                }
              }),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
