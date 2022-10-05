import 'package:cached_network_image/cached_network_image.dart';
import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/images_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = context.read<UserProvider>();
    return Container(
      color: CColors.scaffoldLightBackgroundColor,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Material(
            type: MaterialType.transparency,
            child: Column(
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
                  child: Column(
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
                      const CustomCachedNetworkImage(
                        data: "https://i.pravatar.cc/300",
                        radius: 60.0,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "${userProvider.userInfo.displayName} ",
                            style: const TextStyle(
                                color: CColors.trueWhite,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Inter"),
                          ),
                          const TextSpan(
                            text: "26",
                            style: TextStyle(
                                color: CColors.trueWhite,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Inter"),
                          ),
                        ]),
                      ),
                      const CustomTextHeader3(
                        text: "University of San Carlos",
                        color: CColors.white,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextHeader1(text: "Interests"),
                      const Padding(
                        padding: EdgeInsets.only(top: 24.0),
                        child: CustomTextSubtitle1(
                          text: "Academic",
                          color: CColors.secondaryTextLightColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: const [
                            CustomSecondaryButton(
                                text: "Science", doOnPressed: null),
                            CustomSecondaryButton(
                                text: "Mathematics", doOnPressed: null),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 24.0),
                        child: CustomTextSubtitle1(
                          text: "Sports",
                          color: CColors.secondaryTextLightColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: const [
                            CustomSecondaryButton(
                                text: "Basketball", doOnPressed: null),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 24.0),
                        child: CustomTextSubtitle1(
                          text: "Games",
                          color: CColors.secondaryTextLightColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: const [
                            CustomSecondaryButton(
                                text: "Nba2k22", doOnPressed: null),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 24.0),
                        child: CustomTextSubtitle1(
                          text: "TV Shows",
                          color: CColors.secondaryTextLightColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: const [
                            CustomSecondaryButton(
                                text: "Breaking Bad", doOnPressed: null),
                          ],
                        ),
                      ),
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
          ),
        ),
      ),
    );
  }
}
