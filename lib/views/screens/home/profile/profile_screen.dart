import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import 'package:tara/core/models/user_model.dart';
import 'package:tara/core/providers/user_provider.dart';
import 'package:tara/core/viewmodels/profile_viewmodel.dart';
import 'package:tara/utilities/configs/custom_icons.dart';
import 'package:tara/utilities/constants/image_constant.dart';
import 'package:tara/utilities/constants/string_constant.dart';
import 'package:tara/utilities/constants/themes_constant.dart';
import 'package:tara/views/commons/images_common.dart';
import 'package:tara/views/commons/texts_common.dart';
import 'package:tara/views/screens/home/profile/edit_profile_screen.dart';

/// SECTION ProfileScreen
/// ProfileScreen Class
///
/// @author Chiekko Red
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewModel profileVM = ProfileViewModel();
  late Future<QuerySnapshot<Map<String, dynamic>>> getInterests;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> interestListForUpdate = [];
  bool isLoaded = false;

  @override
  void initState() {
    UserModel user = context.read<UserProvider>().userInfo;
    getInterests = profileVM.getUserInterests(user.uid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = context.read<UserProvider>();
    return Container(
      color: CColors.scaffoldLightBackgroundColor,
      child: SafeArea(
        child: Material(
          type: MaterialType.transparency,
          child: RefreshIndicator(
            // SECTION Refresh Interest List
            onRefresh: (() async {
              interestListForUpdate = [];
              // NOTE Update User Provider by getting user details from Firestore again
              userProvider
                  .setUser(userProvider.userInfo.uid)
                  // NOTE Then refresh getUserInterests
                  .then((value) => setState(() {
                        getInterests = profileVM
                            .getUserInterests(userProvider.userInfo.uid);
                      }));
            }),
            // !SECTION
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                CColors.scaffoldLightBackgroundColor,
                                CColors.buttonLightColor
                              ])),
                      // SECTION Consumer for UserProvider updates
                      child: Consumer<UserProvider>(
                          builder: (context, userProviderConsumer, widget) {
                        return Column(
                          children: [
                            // SECTION Profile Edit Button
                            GestureDetector(
                              onTap: () {
                                isLoaded
                                    ? pushNewScreen(context,
                                            screen: EditProfileScreen(
                                              uid: userProvider.userInfo.uid,
                                              interestList:
                                                  interestListForUpdate,
                                            ),
                                            withNavBar: false)
                                        .then((value) => setState(() {
                                              userProvider.setUser(
                                                  userProvider.userInfo.uid);
                                              getInterests = profileVM
                                                  .getUserInterests(userProvider
                                                      .userInfo.uid);
                                            }))
                                    : null;
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(CustomIcons.edit),
                                ),
                              ),
                            ),

                            // !SECTION
                            const SizedBox(
                              height: 8.0,
                            ),
                            // SECTION Profile Avatar
                            Container(
                                width: 120.0,
                                height: 120.0,
                                decoration: const BoxDecoration(
                                    color: CColors.secondaryColor,
                                    shape: BoxShape.circle),
                                child: isSVG(
                                        userProviderConsumer.userInfo.photoURL)
                                    ? SvgPicture.network(
                                        userProviderConsumer.userInfo.photoURL)
                                    : CustomCachedNetworkImage(
                                        data: userProviderConsumer
                                            .userInfo.photoURL,
                                        radius: 60)),

                            // !SECTION
                            const SizedBox(
                              height: 16.0,
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text:
                                      "${userProviderConsumer.userInfo.displayName}, ",
                                  style: const TextStyle(
                                      color: CColors.trueWhite,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Inter"),
                                ),
                                TextSpan(
                                  text: userProviderConsumer.userInfo.age,
                                  style: const TextStyle(
                                      color: CColors.trueWhite,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Inter"),
                                ),
                              ]),
                            ),
                            CustomTextHeader3(
                              text: userProviderConsumer.userInfo.school,
                              color: CColors.white,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                          ],
                        );
                      }),
                      // !SECTION
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 16.0),
                      // SECTION Interests Section
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextHeader1(text: "Interests"),
                          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              future: getInterests,
                              builder: (context, interestsSnapshot) {
                                if (interestsSnapshot.hasError) {
                                  debugPrint("❌ [UserInterests] Error");
                                  return const CustomTextHeader2(
                                    text: "Error",
                                    color: CColors.secondaryTextLightColor,
                                  );
                                }

                                if (interestsSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  debugPrint("⏳ [UserInterests] Waiting");
                                  return Center(
                                    child: Platform.isIOS
                                        ? const CupertinoActivityIndicator(
                                            color: CColors.secondaryColor)
                                        : const CircularProgressIndicator(
                                            color: CColors.secondaryColor),
                                  );
                                }
                                // SECTION Interest List
                                debugPrint("🗂 [UserInterests] Has Data");
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        interestsSnapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      isLoaded = true;
                                      QueryDocumentSnapshot<
                                              Map<String, dynamic>> interests =
                                          interestsSnapshot.data!.docs[index];
                                      interestListForUpdate.add(interests);
                                      List<dynamic> interestList =
                                          interests["interestList"];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // SECTION Interest Name
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 24.0),
                                            child: CustomTextSubtitle1(
                                              text: interests["name"],
                                              color: CColors
                                                  .secondaryTextLightColor,
                                            ),
                                          ),
                                          // !SECTION Interest Name

                                          // SECTION Interests Tags
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Wrap(
                                                children: interestList
                                                    .map((dynamic el) =>
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 8.0),
                                                          child: Chip(
                                                            label: Text(
                                                                titleCase(el)),
                                                            labelStyle:
                                                                customTextHeader3(),
                                                          ),
                                                        ))
                                                    .toList()),
                                          ),
                                          // !SECTION
                                        ],
                                      );
                                    });
                                // !SECTION
                              }),
                          // const Divider(),
                          // const SizedBox(
                          //   height: 24.0,
                          // ),
                          // const CustomTextHeader1(text: "Saved Users")
                        ],
                      ),
                      // !SECTION
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/// !SECTION 