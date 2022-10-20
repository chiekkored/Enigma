// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/core/viewmodels/profile_viewmodel.dart';
import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/interest_suggestions_constant.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/images_common.dart';
import 'package:enigma/views/commons/inputs_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/home/profile/profile_screen.dart';

/// SECTION EditProfileScreen
/// EditProfileScreen Class
///
/// @author Thomas Rey B Barcenas
class EditProfileScreen extends StatefulWidget {
  final String uid;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> interestList;
  const EditProfileScreen({
    Key? key,
    required this.uid,
    required this.interestList,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  /// ANCHOR Variables
  ProfileViewModel profileVM = ProfileViewModel();
  FirebaseAuth user = FirebaseAuth.instance;
  TextEditingController displayNameTextController = TextEditingController();
  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController ageTextController = TextEditingController();
  List<dynamic> academicInterests = [];
  List<dynamic> sportsInterests = [];
  List<dynamic> gameInterests = [];
  List<dynamic> tvShowInterests = [];
  String temporaryProfileAvatar = '';
  String displayNameErrorTxt = '';
  String fullNameErrorTxt = '';
  String ageErrorTxt = '';
  bool displayNameValidator = false;
  bool fullNameValidator = false;
  bool ageValidator = false;
  bool isLoading = false;

  // SECTION editProfileAttempt
  editProfileAttempt() {
    // NOTE checks for empty text forms and returns false
    if (displayNameTextController.text == '') {
      setState(() {
        displayNameErrorTxt = 'Display Name is required';
        displayNameValidator = true;
        fullNameValidator = false;
        ageValidator = false;
      });
      debugPrint('👿 Display name is empty.');
      return false;
    } else if (fullNameTextController.text == '') {
      setState(() {
        fullNameErrorTxt = 'Please enter your full name';
        displayNameValidator = false;
        fullNameValidator = true;
        ageValidator = false;
      });
      debugPrint('👿 Full name is empty');
      return false;
    } else if (ageTextController.text == '') {
      setState(() {
        ageErrorTxt = 'Please enter your age';
        displayNameValidator = false;
        fullNameValidator = false;
        ageValidator = true;
      });
      debugPrint('👿 Age is empty');
      return false;
    } else {
      return true;
    }
  }

  // !SECTION

  // SECTION initState
  @override
  void initState() {
    super.initState();
    var userProvider = context.read<UserProvider>();
    var academics = widget.interestList
        .where((element) => element.data()['name'].contains("Academics"))
        .toList();
    var sports = widget.interestList
        .where((element) => element.data()['name'].contains("Sports"))
        .toList();
    var games = widget.interestList
        .where((element) => element.data()['name'].contains("Games"))
        .toList();
    var tvShows = widget.interestList
        .where((element) => element.data()['name'].contains("TV Shows"))
        .toList();

    displayNameTextController.text = userProvider.userInfo.displayName;
    fullNameTextController.text = userProvider.userInfo.fullName;
    ageTextController.text = userProvider.userInfo.age;
    academicInterests = academics.first["interestList"];
    sportsInterests = sports.first["interestList"];
    gameInterests = games.first["interestList"];
    tvShowInterests = tvShows.first["interestList"];
  }

  // !SECTION

  @override
  Widget build(BuildContext context) {
    // ANCHOR Context Variables
    var userProvider = context.read<UserProvider>();
    final ImagePicker picker = ImagePicker();
    double height = MediaQuery.of(context).size.height;
    // .substring(0, userProvider.userInfo.photoURL.indexOf("?"));

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
                MaterialPageRoute(builder: (_) => const ProfileScreen()));
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
                        children: [
                          // SECTION Profile Avatar
                          Center(
                            child: Stack(
                              children: [
                                // NOTE Avatar Outer Ring
                                const CircleAvatar(
                                    radius: 55.0,
                                    backgroundColor: CColors.buttonLightColor,
                                    child: CircleAvatar(
                                      radius: 50.0,
                                      backgroundColor: CColors.trueWhite,
                                    )),

                                // NOTE User Avatar
                                temporaryProfileAvatar.split('.').last == 'svg'
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
                                            temporaryProfileAvatar == ''
                                                ? userProvider.userInfo.photoURL
                                                : temporaryProfileAvatar),
                                      )
                                    : Positioned(
                                        top: 5.0,
                                        left: 5.0,
                                        child: temporaryProfileAvatar == ''
                                            ? CustomDisplayPhotoURL(
                                                photoURL: userProvider
                                                    .userInfo.photoURL,
                                                radius: 50.0)
                                            : CircleAvatar(
                                                radius: 50.0,
                                                backgroundColor:
                                                    CColors.trueWhite,
                                                foregroundImage: FileImage(File(
                                                    temporaryProfileAvatar))),
                                      ),

                                // NOTE Edit Avatar Button
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
                                                      // NOTE Image Capture
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
                                                                temporaryProfileAvatar =
                                                                    photo!.path;
                                                              });
                                                              if (!mounted) {
                                                                return;
                                                              }
                                                              Navigator.pop(
                                                                  context);
                                                              debugPrint(
                                                                  '🤳🤳🤳 ${userProvider.userInfo.photoURL}');
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

                                                      // NOTE Gallery Select
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
                                                                temporaryProfileAvatar =
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

                                                      // NOTE Avatar Select
                                                      default:
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              temporaryProfileAvatar =
                                                                  "https://avatars.dicebear.com/api/adventurer/${userProvider.userInfo.displayName}$index.svg";
                                                              debugPrint(
                                                                  '👀$temporaryProfileAvatar');
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
                                                    }
                                                  }),
                                            ))),
                                      ),

                                      // !SECTION
                                    )),
                              ],
                            ),
                          ),

                          // !SECTION
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
                          // SECTION Academics
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: CustomTextHeader2(
                                  text: 'Academics:',
                                  color: CColors.secondaryTextLightColor),
                            ),
                          ),
                          CustomTextFieldTagsForInterestsUpdate(
                            suggestions: academicsSuggestions,
                            textCapitalization: true,
                            hintText: 'Academic Interests',
                            tagEmoji: '📚',
                            interests: academicInterests,
                          ),

                          // !SECTION
                          // SECTION Sports
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: CustomTextHeader2(
                                  text: 'Sports:',
                                  color: CColors.secondaryTextLightColor),
                            ),
                          ),
                          CustomTextFieldTagsForInterestsUpdate(
                            suggestions: sportsSuggestions,
                            textCapitalization: true,
                            hintText: 'Sport Interests',
                            tagEmoji: '🏅',
                            interests: sportsInterests,
                          ),

                          // !SECTION
                          // SECTION Games
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: CustomTextHeader2(
                                  text: 'Games:',
                                  color: CColors.secondaryTextLightColor),
                            ),
                          ),
                          CustomTextFieldTagsForInterestsUpdate(
                            textCapitalization: true,
                            hintText: 'Game Interests',
                            tagEmoji: '🕹',
                            interests: gameInterests,
                          ),

                          // !SECTION
                          // SECTION TV Shows
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: CustomTextHeader2(
                                  text: 'TV Shows:',
                                  color: CColors.secondaryTextLightColor),
                            ),
                          ),
                          CustomTextFieldTagsForInterestsUpdate(
                            textCapitalization: true,
                            hintText: 'TV Show Interests',
                            tagEmoji: '📺',
                            interests: tvShowInterests,
                          ),

                          // !SECTION
                        ],
                      ))))),
      bottomNavigationBar:

          /// SECTION Update Button
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
                  text: 'Update Profile',
                  doOnPressed: () async {
                    if (editProfileAttempt()) {
                      ProfileViewModel profileVM = ProfileViewModel();
                      setState(() {
                        isLoading = true;
                      });
                      await profileVM
                          .updateUserProfile(
                              temporaryProfileAvatar,
                              displayNameTextController.text,
                              fullNameTextController.text,
                              ageTextController.text,
                              userProvider.userInfo.uid,
                              academicInterests,
                              sportsInterests,
                              gameInterests,
                              tvShowInterests)
                          .then((value) {
                        userProvider
                            .setUser(userProvider.userInfo.uid)
                            .then((value) {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ProfileScreen()));
                        });
                      });
                    }
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
