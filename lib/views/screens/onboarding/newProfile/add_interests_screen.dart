// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/inputs_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/onboarding/newProfile/new_profile_screen.dart';
import 'package:enigma/views/screens/onboarding/newProfile/profile_update_success_screen.dart';
import 'package:flutter/material.dart';

/// SECTION AddInterestScreen
/// AddInterestScreen class
///
/// @author Thomas Rey B Barcenas
class AddInterestScreen extends StatefulWidget {
  final String userAvatar;
  final String displayName;
  final String fullName;
  final String age;
  final String school;
  const AddInterestScreen({
    Key? key,
    required this.userAvatar,
    required this.displayName,
    required this.fullName,
    required this.age,
    required this.school,
  }) : super(key: key);

  @override
  State<AddInterestScreen> createState() => _AddInterestScreenState();
}

class _AddInterestScreenState extends State<AddInterestScreen> {
  // ANCHOR Variables
  List<String> academicInterests = [];
  List<String> sportsInterests = [];
  List<String> gameInterests = [];
  List<String> tvShowInterests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CColors.trueWhite,
      // SECTION Back Btn
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          color: CColors.secondaryColor,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: CColors.secondaryColor,
            size: 48,
          ),
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (_) => const NewProfileScreen()));
          },
        ),
      ),
      // !SECTION

      body: Container(
        color: CColors.trueWhite,
        child: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: CustomTextHeader1(text: 'Add your interests!'),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  // SECTION Academics
                  child: CustomTextHeader2(
                      text: 'Academics:',
                      color: CColors.secondaryTextLightColor),
                ),
                CustomTextFieldTagsTemp(
                  hintText: 'Interest',
                  interests: academicInterests,
                ),

                // !SECTION
                // SECTION Sports
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: CustomTextHeader2(
                      text: 'Sports:', color: CColors.secondaryTextLightColor),
                ),
                CustomTextFieldTagsTemp(
                  hintText: 'Interest',
                  interests: sportsInterests,
                ),

                // !SECTION
                // SECTION Games
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: CustomTextHeader2(
                      text: 'Games:', color: CColors.secondaryTextLightColor),
                ),
                CustomTextFieldTagsTemp(
                  hintText: 'Interest',
                  interests: gameInterests,
                ),

                // !SECTION
                // SECTION TV Shows
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: CustomTextHeader2(
                      text: 'TV Shows:',
                      color: CColors.secondaryTextLightColor),
                ),
                CustomTextFieldTagsTemp(
                  hintText: 'Interest',
                  interests: tvShowInterests,
                ),

                // !SECTION
              ],
            ),
          )),
        ),
      ),

      bottomNavigationBar:

          /// SECTION Next Btn
          SafeArea(
        child: Container(
          color: CColors.trueWhite,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: SizedBox(
              height: 50.0,
              child: CustomPrimaryButtonWithDisable(
                disable: false,
                text: 'Next',
                doOnPressed: () async {
                  debugPrint('😮 ${academicInterests.toString()}');
                  debugPrint('😮 ${sportsInterests.toString()}');
                  debugPrint('😮 ${gameInterests.toString()}');
                  debugPrint('😮 ${tvShowInterests.toString()}');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ProfileUpdateSuccessScreen(
                                userAvatar: widget.userAvatar,
                                displayName: widget.displayName,
                                fullName: widget.fullName,
                                age: widget.age,
                                school: widget.school,
                                academicInterests: academicInterests,
                                sportsInterests: sportsInterests,
                                gameInterests: gameInterests,
                                tvShowInterests: tvShowInterests,
                              )));
                },
              ),
            ),
          ),
        ),
      ),

      /// !SECTION
    );
  }
}

// !SECTION