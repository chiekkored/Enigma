import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/user_model.dart';
import 'package:enigma/core/viewmodels/profile_viewmodel.dart';
import 'package:enigma/views/commons/images_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/texts_common.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewModel profileVM = ProfileViewModel();
  late Future<QuerySnapshot<Map<String, dynamic>>> getInterests;

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
            onRefresh: (() async {
              userProvider
                  .setUser(userProvider.userInfo.uid)
                  .then((value) => setState(() {
                        getInterests = profileVM
                            .getUserInterests(userProvider.userInfo.uid);
                      }));
            }),
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
                      child: Consumer<UserProvider>(
                          builder: (context, userProviderConsumer, widget) {
                        return Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(CustomIcons.edit),
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Container(
                                width: 120.0,
                                height: 120.0,
                                decoration: const BoxDecoration(
                                    color: Colors.blue, shape: BoxShape.circle),
                                child: userProviderConsumer.userInfo.photoURL
                                            .split('.')
                                            .last ==
                                        'svg'
                                    ? SvgPicture.network(
                                        userProviderConsumer.userInfo.photoURL)
                                    : CustomCachedNetworkImage(
                                        data: userProviderConsumer
                                            .userInfo.photoURL,
                                        radius: 60)),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextHeader1(text: "Interests"),
                          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              future: getInterests,
                              builder: (context, interestsSnapshot) {
                                if (interestsSnapshot.hasError) {
                                  return const CustomTextHeader2(
                                    text: "Error",
                                    color: CColors.secondaryTextLightColor,
                                  );
                                }

                                if (interestsSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: Platform.isIOS
                                        ? const CupertinoActivityIndicator(
                                            color: CColors.secondaryColor)
                                        : const CircularProgressIndicator(
                                            color: CColors.secondaryColor),
                                  );
                                }
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        interestsSnapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      QueryDocumentSnapshot<
                                              Map<String, dynamic>> interests =
                                          interestsSnapshot.data!.docs[index];
                                      List<dynamic> interestList =
                                          interests["interestList"];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 24.0),
                                            child: CustomTextSubtitle1(
                                              text: interests["name"],
                                              color: CColors
                                                  .secondaryTextLightColor,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                                children: interestList
                                                    .map(
                                                        (dynamic el) => Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  CustomTextHeader3(
                                                                      text: el),
                                                            ))
                                                    .toList()),
                                          ),
                                        ],
                                      );
                                    });
                              }),
                          const Divider(),
                          const SizedBox(
                            height: 24.0,
                          ),
                          const CustomTextHeader1(text: "Saved Users")
                        ],
                      ),
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
