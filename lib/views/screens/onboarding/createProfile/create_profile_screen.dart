import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/core/viewmodels/auth_viewmodel.dart';
import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/inputs_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/auth/login_screen.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  /// ANCHOR Variables
  final AuthViewModel _authVM = AuthViewModel();
  TextEditingController displayNameTextController = TextEditingController();
  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController ageTextController = TextEditingController();
  TextEditingController schoolTextController = TextEditingController();
  String displayNameErrorTxt = '';
  String fullNameErrorTxt = '';
  String ageErrorTxt = '';
  String schoolErrorTxt = '';
  bool displayNameValidator = false;
  bool fullNameValidator = false;
  bool ageValidator = false;
  bool schoolValidator = false;

  /// SECTION createProfileAttempt function
  createProfileAttempt() {
    // NOTE checks for empty text forms and returns false
    if (displayNameTextController.text == '') {
      setState(() {
        displayNameErrorTxt = 'Display Name is required';
        displayNameValidator = true;
        fullNameValidator = false;
        ageValidator = false;
        schoolValidator = false;
      });
      debugPrint('👿 Display name is empty.');
      return false;
    }
    if (fullNameTextController.text == '') {
      setState(() {
        fullNameErrorTxt = 'Please enter your full name';
        displayNameValidator = false;
        fullNameValidator = true;
        ageValidator = false;
        schoolValidator = false;
      });
      debugPrint('👿 Full name is empty');
      return false;
    }
    if (ageTextController.text == '') {
      setState(() {
        ageErrorTxt = 'Please enter your age';
        displayNameValidator = false;
        fullNameValidator = false;
        ageValidator = true;
        schoolValidator = false;
      });
      debugPrint('👿 Age is empty');
      return false;
    }
    if (schoolTextController.text == '') {
      setState(() {
        schoolErrorTxt = 'Please enter your School/University name';
        displayNameValidator = false;
        fullNameValidator = false;
        ageValidator = false;
        schoolValidator = true;
      });
      debugPrint('👿 School is empty');
      return false;
    }
    // NOTE checks the users age if over 18 or not
    if (int.parse(ageTextController.text) < 18) {
      setState(() {
        ageErrorTxt = 'Students should be 18 and above to use this app.';
        displayNameValidator = false;
        fullNameValidator = false;
        ageValidator = true;
        schoolValidator = false;
      });
      debugPrint('👿 Age is less than 18');
      return false;
    }
    // NOTE when text forms are not empty and the user is 18 or above, returns true
    return true;
  }

  /// !SECTION

  @override
  Widget build(BuildContext context) {
    var userProvider = context.read<UserProvider>();
    // SECTION Grid design configuration
    var crossAxisSpacing = 25;
    var screenWidth = MediaQuery.of(context).size.width;
    var crossAxisCount = 2;
    var width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    var cellHeight = 250;
    var aspectRatio = width / cellHeight;

    // !SECTION
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CColors.trueWhite,
      body: Container(
        color: CColors.trueWhite,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 50.0),
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                      /// SECTION Profile Picture
                      Center(
                        child: Stack(children: [
                          const CircleAvatar(
                            radius: 55.0,
                            backgroundColor: CColors.buttonLightColor,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: CColors.trueWhite,
                            ),
                          ),
                          Positioned(
                            top: 8.0,
                            left: 5.0,
                            child: SvgPicture.network(
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.scaleDown,
                                "https://avatars.dicebear.com/api/adventurer/${userProvider.userInfo.displayName}.svg"),
                          ),
                          Positioned(
                              top: 70.0,
                              left: 75.0,
                              child: GestureDetector(
                                child: const CircleAvatar(
                                  radius: 17.0,
                                  backgroundColor: CColors.buttonLightColor,
                                  child: Icon(CustomIcons.edit, size: 16.0),
                                ),
                                onTap: () => showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: ((context) => Container(
                                      decoration: const BoxDecoration(
                                          color: CColors.trueWhite,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16.0),
                                              topRight: Radius.circular(16.0))),
                                      child: SizedBox(
                                        height: 250.0,
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 25.0,
                                              mainAxisSpacing: 10.0,
                                              childAspectRatio: aspectRatio,
                                            ),
                                            itemCount: 30,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    color: Colors.red),
                                              );
                                            }),
                                      ))),
                                ),
                              ))
                        ]),
                      ),

                      /// !SECTION
                      /// SECTION displayName TextForm
                      Padding(
                          padding: const EdgeInsets.only(top: 29.0),
                          child: CustomAuthInput(
                            obscureText: false,
                            icon: CustomIcons.profile_fill,
                            hintText: 'Display Name',
                            controller: displayNameTextController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                          )),

                      /// !SECTION
                      /// SECTION displayName Error Text
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 6.0),
                          child: Visibility(
                              visible: displayNameValidator,
                              child: CustomTextSubtitle1(
                                  text: displayNameErrorTxt,
                                  color: CColors.dangerColor)),
                        ),
                      ),

                      /// !SECTION
                      /// SECTION fullName TextForm
                      Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: CustomAuthInput(
                            obscureText: false,
                            icon: Icons.badge_rounded,
                            hintText: 'Full Name',
                            controller: fullNameTextController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                          )),

                      /// !SECTION
                      /// SECTION fullName Error Text
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 6.0),
                          child: Visibility(
                              visible: fullNameValidator,
                              child: CustomTextSubtitle1(
                                  text: fullNameErrorTxt,
                                  color: CColors.dangerColor)),
                        ),
                      ),

                      /// !SECTION
                      /// SECTION age TextForm
                      Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: CustomAuthInput(
                            obscureText: false,
                            icon: Icons.info,
                            hintText: 'Age',
                            controller: ageTextController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                          )),

                      /// !SECTION
                      /// SECTION age Error Text
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 6.0),
                          child: Visibility(
                              visible: ageValidator,
                              child: CustomTextSubtitle1(
                                  text: ageErrorTxt,
                                  color: CColors.dangerColor)),
                        ),
                      ),

                      /// !SECTION
                      /// SECTION school TextForm
                      Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: CustomAuthInput(
                            obscureText: false,
                            icon: Icons.school,
                            hintText: 'School/University',
                            controller: schoolTextController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                          )),

                      /// !SECTION
                      /// SECTION school Error Text
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 6.0),
                          child: Visibility(
                              visible: schoolValidator,
                              child: CustomTextSubtitle1(
                                  text: schoolErrorTxt,
                                  color: CColors.dangerColor)),
                        ),
                      ),

                      /// !SECTION
                    ]))),
          ),
        ),
      ),
      bottomNavigationBar:

          /// SECTION Next Button
          SafeArea(
        child: Container(
          color: CColors.trueWhite,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: SizedBox(
              height: 40.0,
              child: CustomPrimaryButtonWithDisable(
                  text: 'Next',
                  disable: false,
                  doOnPressed: () async {
                    if (createProfileAttempt()) {
                      // ignore: todo
                      // TODO
                      // ignore: fixme
                      // FIXME delete this
                      _authVM.logout();
                      Navigator.of(context, rootNavigator: true)
                          .pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (route) => false);
                    }
                  }),
            ),
          ),
        ),
      ),

      /// !SECTION
    );
  }
}
