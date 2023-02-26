import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:tara/core/providers/user_provider.dart';
import 'package:tara/utilities/configs/custom_icons.dart';
import 'package:tara/utilities/constants/themes_constant.dart';
import 'package:tara/views/commons/buttons_common.dart';
import 'package:tara/views/commons/inputs_common.dart';
import 'package:tara/views/commons/texts_common.dart';
import 'package:tara/views/screens/onboarding/newProfile/add_interests_screen.dart';

/// SECTION NewProfileScreen
/// NewProfileScreen class
///
/// @author Thomas Rey B Barcenas
class NewProfileScreen extends StatefulWidget {
  const NewProfileScreen({Key? key}) : super(key: key);

  @override
  State<NewProfileScreen> createState() => _NewProfileScreenState();
}

class _NewProfileScreenState extends State<NewProfileScreen> {
  /// ANCHOR Variables
  TextEditingController displayNameTextController = TextEditingController();
  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController ageTextController = TextEditingController();
  TextEditingController schoolTextController = TextEditingController();
  String displayNameErrorTxt = '';
  String fullNameErrorTxt = '';
  String ageErrorTxt = '';
  String schoolErrorTxt = '';
  String userAvatar = '';
  bool displayNameValidator = false;
  bool fullNameValidator = false;
  bool ageValidator = false;
  bool schoolValidator = false;
  FirebaseAuth user = FirebaseAuth.instance;

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
      var userProvider = context.read<UserProvider>();
      if (userProvider.userInfo.school.isEmpty) {
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
      return true;
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

  // !SECTION

  /// SECTION initState
  @override
  void initState() {
    super.initState();
    displayNameTextController.text = user.currentUser!.email!
        .substring(0, user.currentUser!.email!.indexOf('@'));
    userAvatar =
        "https://avatars.dicebear.com/api/adventurer/${user.currentUser!.email!.substring(0, user.currentUser!.email!.indexOf('@'))}.svg";
  }

  // !SECTION

  @override
  Widget build(BuildContext context) {
    // ANCHOR Context Variables
    final ImagePicker picker = ImagePicker();
    double height = MediaQuery.of(context).size.height;
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
    return Listener(
      onPointerDown: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CColors.trueWhite,
        body: Container(
          color: CColors.trueWhite,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  // const Align(
                  //   alignment: Alignment.topCenter,
                  //   child: LinearProgressIndicator(
                  //       value: 0.33,
                  //       color: CColors.buttonLightColor,
                  //       backgroundColor: Colors.transparent),
                  // ),
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 50.0),
                          child:
                              Column(mainAxisSize: MainAxisSize.max, children: [
                            /// SECTION Profile Avatar
                            Center(
                              child: Stack(children: [
                                // SECTION Outer ring circle for the avatar
                                const CircleAvatar(
                                  radius: 55.0,
                                  backgroundColor: CColors.buttonLightColor,
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    backgroundColor: CColors.trueWhite,
                                  ),
                                ),

                                // !SECTION
                                // SECTION User's Avatar
                                // NOTE Checks the file type of the image
                                userAvatar.split('.').last == 'svg'
                                    ? Positioned(
                                        top: 9.0,
                                        left: 9.0,
                                        child: SvgPicture.network(
                                            placeholderBuilder: (context) {
                                          return Transform.translate(
                                              offset: const Offset(-4, -4),
                                              child: Shimmer.fromColors(
                                                baseColor: CColors.trueWhite,
                                                highlightColor:
                                                    CColors.strokeColor,
                                                child: const CircleAvatar(
                                                    radius: 50.0,
                                                    backgroundColor:
                                                        CColors.trueWhite),
                                              ));
                                        },
                                            width: 90.0,
                                            height: 90.0,
                                            fit: BoxFit.scaleDown,
                                            userAvatar),
                                      )
                                    : Positioned(
                                        top: 5.0,
                                        left: 5.0,
                                        child: CircleAvatar(
                                            radius: 50.0,
                                            backgroundColor: CColors.trueWhite,
                                            foregroundImage:
                                                FileImage(File(userAvatar)))),

                                // !SECTION
                                // SECTION Edit Avatar Btn
                                Positioned(
                                    top: 70.0,
                                    left: 75.0,
                                    child: GestureDetector(
                                      child: const CircleAvatar(
                                        radius: 17.0,
                                        backgroundColor:
                                            CColors.buttonLightColor,
                                        child:
                                            Icon(CustomIcons.edit, size: 16.0),
                                      ),
                                      // SECTION showModalBottomSheet
                                      onTap: () => showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        builder: ((context) => Container(
                                            decoration: const BoxDecoration(
                                                color: CColors.trueWhite,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16.0),
                                                    topRight:
                                                        Radius.circular(16.0))),
                                            child: SizedBox(
                                              height: height / 2,
                                              child: GridView.builder(
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing: 25.0,
                                                    mainAxisSpacing: 10.0,
                                                    childAspectRatio:
                                                        aspectRatio,
                                                  ),
                                                  itemCount: 32,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    switch (index) {
                                                      // SECTION Image Capture
                                                      case 0:
                                                        return GestureDetector(
                                                            onTap: () async {
                                                              final XFile?
                                                                  photo =
                                                                  await picker
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.camera);
                                                              setState(() {
                                                                userAvatar =
                                                                    photo!.path;
                                                              });
                                                              if (!mounted) {
                                                                return;
                                                              }
                                                              Navigator.pop(
                                                                  context);
                                                              debugPrint(
                                                                  '🤳🤳🤳 $userAvatar');
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      20.0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                      'assets/icons/camera.svg'),
                                                            ));
                                                      // !SECTION
                                                      // SECTION Gallery Select
                                                      case 1:
                                                        return GestureDetector(
                                                            onTap: () async {
                                                              final XFile?
                                                                  image =
                                                                  await picker
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.gallery);
                                                              setState(() {
                                                                userAvatar =
                                                                    image!.path;
                                                              });
                                                              if (!mounted) {
                                                                return;
                                                              }
                                                              Navigator.pop(
                                                                  context);
                                                              debugPrint(
                                                                  '🤳🤳🤳${image!.path}');
                                                            },
                                                            child: const Icon(
                                                                size: 70.0,
                                                                CustomIcons
                                                                    .image_add));
                                                      // !SECTION
                                                      // SECTION Avatar Select
                                                      default:
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              userAvatar =
                                                                  "https://avatars.dicebear.com/api/adventurer/${userProvider.userInfo.displayName}$index.svg";
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: SvgPicture.network(
                                                                placeholderBuilder:
                                                                    (context) {
                                                              return Transform
                                                                  .translate(
                                                                      offset:
                                                                          const Offset(
                                                                              -4,
                                                                              -4),
                                                                      child: Shimmer
                                                                          .fromColors(
                                                                        baseColor:
                                                                            CColors.trueWhite,
                                                                        highlightColor:
                                                                            CColors.strokeColor,
                                                                        child: const CircleAvatar(
                                                                            radius:
                                                                                50.0,
                                                                            backgroundColor:
                                                                                CColors.trueWhite),
                                                                      ));
                                                            },
                                                                width: 90.0,
                                                                height: 90.0,
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                "https://avatars.dicebear.com/api/adventurer/${userProvider.userInfo.displayName}$index.svg"),
                                                          ),
                                                        );
                                                      // !SECTION
                                                    }
                                                  }),
                                            ))),
                                      ),

                                      // !SECTION
                                    )),

                                // !SECTION
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
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 6.0),
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
                                  textCapitalization: true,
                                  obscureText: false,
                                  icon: Icons.badge_rounded,
                                  hintText: 'Full Name',
                                  controller: fullNameTextController,
                                  textInputAction: TextInputAction.next,
                                  // keyboardType: TextInputType.name,
                                )),

                            /// !SECTION
                            /// SECTION fullName Error Text
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 6.0),
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
                                  textInputAction:
                                      userProvider.userInfo.school == ''
                                          ? TextInputAction.next
                                          : TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                )),

                            /// !SECTION
                            /// SECTION age Error Text
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 6.0),
                                child: Visibility(
                                    visible: ageValidator,
                                    child: CustomTextSubtitle1(
                                        text: ageErrorTxt,
                                        color: CColors.dangerColor)),
                              ),
                            ),

                            /// !SECTION
                            /// SECTION school TextForm
                            Visibility(
                              visible: userProvider.userInfo.school == ''
                                  ? true
                                  : false,
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: CustomAuthInput(
                                    obscureText: false,
                                    icon: Icons.school,
                                    hintText: 'School/University',
                                    controller: schoolTextController,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.text,
                                  )),
                            ),

                            /// !SECTION
                            /// SECTION school Error Text
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 6.0),
                                child: Visibility(
                                    visible: schoolValidator,
                                    child: CustomTextSubtitle1(
                                        text: schoolErrorTxt,
                                        color: CColors.dangerColor)),
                              ),
                            ),

                            /// !SECTION
                          ]))),
                ],
              ),
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
                height: 50.0,
                child: CustomPrimaryButtonWithDisable(
                    text: 'Next',
                    disable: false,
                    doOnPressed: () {
                      if (createProfileAttempt()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AddInterestScreen(
                                      userAvatar: userAvatar,
                                      displayName:
                                          displayNameTextController.text,
                                      fullName: fullNameTextController.text,
                                      age: ageTextController.text,
                                      school: schoolTextController.text,
                                    )));
                      }
                    }),
              ),
            ),
          ),
        ),

        /// !SECTION
      ),
    );
  }
}
// !SECTION
