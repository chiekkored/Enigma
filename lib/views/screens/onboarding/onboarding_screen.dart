import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 1;
  final List<String> _images = ["image1", "image2", "image3"];
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
                  Text(_images[_step - 1]),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CustomTextBodyText1(
                        textAlign: TextAlign.center,
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
              onTap: (() => setState(() {
                    _step < 3 ? _step += 1 : _step;
                  })),
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
