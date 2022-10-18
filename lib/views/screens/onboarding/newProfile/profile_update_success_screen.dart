import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/core/viewmodels/new_profile_viewmodel.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/home/navigation.dart';
import 'package:enigma/views/screens/onboarding/newProfile/add_interests_screen.dart';

/// SECTION ProfileUpdateSuccessScreen
/// ProfileUpdateSuccessScreen class
///
/// @author Thomas Rey B Barcenas
class ProfileUpdateSuccessScreen extends StatelessWidget {
  final String userAvatar;
  final String displayName;
  final String fullName;
  final String age;
  final String school;
  final List<String> academicInterests;
  final List<String> sportsInterests;
  final List<String> gameInterests;
  final List<String> tvShowInterests;
  const ProfileUpdateSuccessScreen({
    Key? key,
    required this.userAvatar,
    required this.displayName,
    required this.fullName,
    required this.age,
    required this.school,
    required this.academicInterests,
    required this.sportsInterests,
    required this.gameInterests,
    required this.tvShowInterests,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ANCHOR Contect Variables
    var userProvider = context.read<UserProvider>();
    bool isLoading = false;
    return Scaffold(
      backgroundColor: CColors.trueWhite,
      // SECTION Back Button
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
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (_) => AddInterestScreen(
                          userAvatar: userAvatar,
                          displayName: displayName,
                          fullName: fullName,
                          age: age,
                          school: school,
                        )));
          },
        ),
      ),

      // !SECTION
      // SECTION Body
      body: Container(
          color: CColors.trueWhite,
          child: SafeArea(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Align(
              //   alignment: Alignment.topCenter,
              //   child: LinearProgressIndicator(
              //       value: 1,
              //       color: CColors.buttonLightColor,
              //       backgroundColor: Colors.transparent),
              // ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 50.0),
                  child: Column(children: [
                    CustomTextTitle1Centered(
                        text: 'Congratulations, $fullName',
                        color: CColors.secondaryColor),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: CustomTextHeader2Centered(
                          text: "You're now ready to start using Enigma!",
                          color: CColors.secondaryTextLightColor),
                    )
                  ]),
                ),
              )
            ],
          ))),

      // !SECTION
      bottomNavigationBar:

          /// SECTION Start Button
          StatefulBuilder(builder: (context, setState) {
        return SafeArea(
          child: Container(
            color: CColors.trueWhite,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: SizedBox(
                height: 58.0,
                child: CustomPrimaryButtonWithLoading(
                  loading: isLoading,
                  text: 'Start Enigma',
                  doOnPressed: () async {
                    NewProfileViewModel newProfileVM = NewProfileViewModel();
                    setState(() {
                      isLoading = true;
                    });
                    await newProfileVM
                        .updateProfile(
                      userAvatar,
                      displayName,
                      fullName,
                      age,
                      school,
                      userProvider.userInfo.uid,
                      academicInterests,
                      sportsInterests,
                      gameInterests,
                      tvShowInterests,
                    )
                        .then((value) {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Navigation()),
                          (route) => false);
                    });
                  },
                ),
              ),
            ),
          ),
        );
      }),

      /// !SECTION
    );
  }
}

// !SECTION
