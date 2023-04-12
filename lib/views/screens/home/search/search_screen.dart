import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tara/core/providers/user_provider.dart';
import 'package:tara/core/viewmodels/search_viewmodel.dart';
import 'package:tara/utilities/constants/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:tara/core/models/match_user_model.dart';
import 'package:tara/core/viewmodels/profile_viewmodel.dart';
import 'package:tara/utilities/configs/custom_icons.dart';
import 'package:tara/utilities/constants/themes_constant.dart';
import 'package:tara/views/commons/buttons_common.dart';
import 'package:tara/views/commons/images_common.dart';
import 'package:tara/views/commons/popups_commons.dart';
import 'package:tara/views/commons/texts_common.dart';
import 'package:tara/views/screens/home/search/search_loading_screen.dart';

/// SECTION SearchScreen
/// SearchScreen Class
///
/// @author Chiekko Red
class SearchScreen extends StatefulWidget {
  final List<MatchUserModel> myMatches;
  const SearchScreen({super.key, required this.myMatches});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  double? bottomModal;
  late StreamSubscription<bool> keyboardSubscription;
  @override
  void initState() {
    super.initState();
    // NOTE Listen to keyboard visiblity
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      // NOTE If keyboard is visible, open modal to full height
      if (visible) {
        setState(() {
          bottomModal = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileVM = ProfileViewModel();

    UserProvider userProvider = context.read<UserProvider>();
    SearchViewModel searchVM = SearchViewModel();
    // SECTION Grid design configuration
    var crossAxisSpacing = 25;
    var screenWidth = MediaQuery.of(context).size.width;
    var crossAxisCount = 2;
    var width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    var cellHeight = 300;
    var aspectRatio = width / cellHeight;
    // !SECTION
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     onPressed: () => Navigator.pop(context),
      //     icon: const Icon(
      //       Icons.arrow_back_rounded,
      //       color: CColors.secondaryColor,
      //     ),
      //     splashColor: Colors.transparent,
      //     highlightColor: Colors.transparent,
      //   ),
      // ),
      // SECTION Sticky Bottom Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            left: 24.0, right: 24.0, bottom: 26.0, top: 8.0),
        child: OutlinedButton(
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const SearchLoadingScreen())),
          style: OutlinedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: CustomTextHeader3(
              text: "Search again",
              color: CColors.white,
            ),
          ),
        ),
      ),
      // !SECTION
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            // SECTION Back Button
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: CColors.secondaryColor,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ],
            ),
            // !SECTION
            // Align(
            //   alignment: Alignment.centerRight,
            //   // SECTION Filter Button
            //   child: GestureDetector(
            //     // SECTION Bottom Sheet Modal
            //     onTap: () => showModalBottomSheet(
            //       context: context,
            //       isDismissible: false,
            //       isScrollControlled: true,
            //       builder: ((context) => CupertinoPopupSurface(
            //             child: Material(
            //               child: FractionallySizedBox(
            //                 heightFactor: bottomModal,
            //                 child: Container(
            //                   color: CColors.trueWhite,
            //                   padding: const EdgeInsets.all(24.0),
            //                   width: screenWidth,
            //                   child: Column(
            //                     mainAxisSize: MainAxisSize.min,
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       // SECTION Filter Title
            //                       const Center(
            //                           child:
            //                               CustomTextHeader1(text: "Filter")),
            //                       // !SECTION
            //                       const SizedBox(
            //                         height: 8.0,
            //                       ),
            //                       Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: const [
            //                           // SECTION Filter Title
            //                           CustomTextHeader2(
            //                             text: "Add your interests",
            //                             color:
            //                                 CColors.secondaryTextLightColor,
            //                           ),
            //                           // !SECTION

            //                           // SECTION Clear Button
            //                           CustomTextHeader3(
            //                             text: "Clear",
            //                             color: CColors.secondaryColor,
            //                           )
            //                           // !SECTION
            //                         ],
            //                       ),

            //                       // SECTION Filter List
            //                       const Padding(
            //                         padding:
            //                             EdgeInsets.symmetric(vertical: 8.0),
            //                         child: CustomTextHeader2(
            //                           text: "Academics",
            //                           color: CColors.secondaryTextLightColor,
            //                         ),
            //                       ),
            //                       // SECTION Filter Interest Lists Input
            //                       const CustomTextFieldTags(
            //                         hintText: "Academics",
            //                       ),
            //                       // !SECTION
            //                       // !SECTION

            //                       // SECTION Cancel and Apply Button
            //                       Row(
            //                         children: [
            //                           Expanded(
            //                             child: CustomSecondaryButton(
            //                                 text: "Cancel",
            //                                 doOnPressed: () {
            //                                   bottomModal = null;
            //                                   Navigator.pop(context);
            //                                 }),
            //                           ),
            //                           const SizedBox(
            //                             width: 8.0,
            //                           ),
            //                           Expanded(
            //                             child: CustomPrimaryButton(
            //                                 text: "Apply",
            //                                 doOnPressed: () {}),
            //                           ),
            //                         ],
            //                       )
            //                       // !SECTION
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           )),
            //     ),
            //     // !SECTION

            //     // SECTION Filter Button Icon
            //     child: const Icon(CustomIcons.filter),
            //   ),
            // ),
            // !SECTION
            // !SECTION

            // SECTION Title text
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 26.0, top: 18.0),
                child: CustomTextHeader1(text: "Matches your interests"),
              ),
            ),
            // !SECTION

            // SECTION Matched Users Grid
            GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 25.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: widget.myMatches.length,
                itemBuilder: (BuildContext context, int index) {
                  MatchUserModel matchUser = widget.myMatches[index];
                  return GestureDetector(
                    onTap: () {
                      // SECTION Grid user modal
                      showCustomModalWithNoIcon(context,
                          widget: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                  top: -140.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: CustomDisplayPhotoURL(
                                      photoURL: matchUser.photoURL,
                                      radius: 70.0)),
                              const Positioned(
                                  top: 0.0, right: 0.0, child: CloseButton()),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTextHeader1(
                                          text:
                                              "${matchUser.displayName}, ${matchUser.age}"),
                                      CustomTextSubtitle1(
                                        text: matchUser.school,
                                        color: CColors.secondaryColor,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      CustomTextHeader2(text: "Interested in"),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  FutureBuilder<
                                          QuerySnapshot<Map<String, dynamic>>>(
                                      future: profileVM
                                          .getUserInterests(matchUser.uid),
                                      builder: (context, interestsSnapshot) {
                                        if (interestsSnapshot.hasError) {
                                          debugPrint("❌ [UserInterests] Error");
                                          return const CustomTextHeader2(
                                            text: "Error",
                                            color:
                                                CColors.secondaryTextLightColor,
                                          );
                                        }

                                        if (interestsSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          debugPrint(
                                              "⏳ [UserInterests] Waiting");
                                          return Shimmer.fromColors(
                                              baseColor: CColors.white,
                                              highlightColor: CColors.formColor,
                                              child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  shrinkWrap: true,
                                                  itemCount: 4,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Column(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                              width: 50.0,
                                                              height: 20.0,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        const SizedBox(
                                                          height: 12.0,
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3,
                                                            height: 20.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 12.0,
                                                        ),
                                                      ],
                                                    );
                                                  }));
                                        }
                                        debugPrint(
                                            "🗂 [PendingMatchList] Has Data");
                                        return SizedBox(
                                          height: screenWidth / 1.5,
                                          child: ListView.builder(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              itemCount: interestsSnapshot
                                                  .data!.docs.length,
                                              itemBuilder: (context, index) {
                                                QueryDocumentSnapshot<
                                                        Map<String, dynamic>>
                                                    interests =
                                                    interestsSnapshot
                                                        .data!.docs[index];
                                                List<dynamic> interestList =
                                                    interests["interestList"];
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: CustomTextHeader3(
                                                        text: interests["name"],
                                                        color: CColors
                                                            .secondaryTextLightColor,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Wrap(
                                                          direction:
                                                              Axis.horizontal,
                                                          children: interestList
                                                              .map(
                                                                  (dynamic
                                                                          el) =>
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 6.0),
                                                                        child:
                                                                            Chip(
                                                                          label:
                                                                              Text(titleCase(el)),
                                                                          labelStyle:
                                                                              customTextSubtitle1(),
                                                                        ),
                                                                      ))
                                                              .toList()),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        );
                                      }),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomPrimaryButtonWithIcon(
                                          text: "Request Chat",
                                          icon: const Icon(
                                            CustomIcons.chat_fill,
                                            color: Colors.white,
                                          ),
                                          doOnPressed: () async => searchVM
                                              .requestMessageMatch(
                                                  userProvider.userInfo,
                                                  matchUser)
                                              .then((value) {
                                            if (value) {
                                              widget.myMatches.removeWhere(
                                                  (element) =>
                                                      element.uid ==
                                                      matchUser.uid);
                                            }
                                            setState(() {
                                              Navigator.pop(context);
                                            });
                                          }),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ));
                    },
                    // !SECTION

                    // SECTION Grid user display
                    child: Column(
                      children: [
                        CustomDisplayPhotoURL(
                            photoURL: matchUser.photoURL, radius: 50.0),
                        // CustomCachedNetworkImage(
                        //     data: matchUser.photoURL, radius: 50.0),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CustomTextBody2Centered(
                              text:
                                  "${matchUser.displayName}, ${matchUser.age}"),
                        )
                      ],
                    ),
                    // !SECTION
                  );
                })
            // !SECTION
          ],
        )),
      ),
    );
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }
}
/// !SECTION