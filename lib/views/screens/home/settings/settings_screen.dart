import 'dart:io';

import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool darkMode = false;
    bool showReceipt = false;
    return Container(
      color: CColors.scaffoldLightBackgroundColor,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Material(
            type: MaterialType.transparency,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextHeader1(text: "SETTINGS"),

                  // SECTION Dark Mode Toggle
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomTextHeader3(text: "Dark Mode"),
                        StatefulBuilder(builder: (context, setState) {
                          return Platform.isIOS
                              ? CupertinoSwitch(
                                  value: darkMode,
                                  onChanged: (bool value) {
                                    setState(() {
                                      darkMode = value;
                                    });
                                  })
                              : Switch(
                                  value: darkMode,
                                  onChanged: (bool value) {
                                    setState(() {
                                      darkMode = value;
                                    });
                                  });
                        })
                      ],
                    ),
                  ),
                  // !SECTION

                  // SECTION Show Reciept Toggle
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomTextHeader3(text: "Show Read Receipt"),
                            StatefulBuilder(builder: (context, setState) {
                              return Platform.isIOS
                                  ? CupertinoSwitch(
                                      value: showReceipt,
                                      onChanged: (bool value) {
                                        setState(() {
                                          showReceipt = value;
                                        });
                                      })
                                  : Switch(
                                      value: showReceipt,
                                      onChanged: (bool value) {
                                        setState(() {
                                          showReceipt = value;
                                        });
                                      });
                            })
                          ],
                        ),
                        const CustomTextSubtitle1(
                          text:
                              "Let people you're messaging with know when you've seen their messages.",
                          color: CColors.secondaryTextLightColor,
                        )
                      ],
                    ),
                  ),
                  // !SECTION

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Divider(
                      color: CColors.black,
                    ),
                  ),

                  // SECTION Change Password Button
                  GestureDetector(
                    onTap: () {
                      print("pass");
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Icon(
                                    CustomIcons.password_contain,
                                    size: 32.0,
                                  ),
                                ),
                                CustomTextHeader3(text: "Change Password"),
                              ],
                            ),
                          ),
                          const Icon(
                            CustomIcons.right,
                            color: CColors.secondaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // !SECTION

                  // SECTION Notifications Button
                  GestureDetector(
                    onTap: () {
                      print("notif");
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Icon(
                                    CustomIcons.notification,
                                    size: 32.0,
                                  ),
                                ),
                                CustomTextHeader3(text: "Notifications"),
                              ],
                            ),
                          ),
                          const Icon(
                            CustomIcons.right,
                            color: CColors.secondaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // !SECTION

                  // SECTION About Button
                  GestureDetector(
                    onTap: () {
                      print("About");
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Icon(
                                    Icons.info_outline,
                                    size: 32.0,
                                  ),
                                ),
                                CustomTextHeader3(text: "About"),
                              ],
                            ),
                          ),
                          const Icon(
                            CustomIcons.right,
                            color: CColors.secondaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // !SECTION

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Divider(
                      color: CColors.black,
                    ),
                  ),

                  // SECTION Logout Button
                  GestureDetector(
                    onTap: () {
                      print("logout");
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Icon(
                                    CustomIcons.logout,
                                    color: CColors.dangerColor,
                                    size: 32.0,
                                  ),
                                ),
                                CustomTextHeader3(
                                    text: "Logout", color: CColors.dangerColor),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // !SECTION
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
