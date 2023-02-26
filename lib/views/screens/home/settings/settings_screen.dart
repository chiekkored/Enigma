import 'dart:io';

import 'package:tara/core/providers/user_provider.dart';
import 'package:tara/views/commons/buttons_common.dart';
import 'package:tara/views/commons/popups_commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tara/core/viewmodels/auth_viewmodel.dart';
import 'package:tara/utilities/configs/custom_icons.dart';
import 'package:tara/utilities/constants/themes_constant.dart';
import 'package:tara/views/commons/texts_common.dart';
import 'package:tara/views/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

/// SECTION SettingsScreen
/// Settings Screen
///
/// @author Chiekko Red
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    bool darkMode = false;
    bool showReceipt = false;
    double width = MediaQuery.of(context).size.width / 2;
    UserProvider userProvider = context.read<UserProvider>();
    final AuthViewModel authVM = AuthViewModel();
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
                  const Padding(
                    padding: EdgeInsets.only(bottom: 28.0),
                    child: CustomTextHeader1(text: "SETTINGS"),
                  ),

                  // SECTION Dark Mode Toggle
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 28.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       const CustomTextHeader3(text: "Dark Mode"),
                  //       StatefulBuilder(builder: (context, setState) {
                  //         return Platform.isIOS
                  //             ? CupertinoSwitch(
                  //                 value: darkMode,
                  //                 onChanged: (bool value) {
                  //                   setState(() {
                  //                     darkMode = value;
                  //                   });
                  //                 })
                  //             : Switch(
                  //                 value: darkMode,
                  //                 onChanged: (bool value) {
                  //                   setState(() {
                  //                     darkMode = value;
                  //                   });
                  //                 });
                  //       })
                  //     ],
                  //   ),
                  // ),
                  // !SECTION

                  // SECTION Show Reciept Toggle
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 32.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           const CustomTextHeader3(text: "Show Read Receipt"),
                  //           StatefulBuilder(builder: (context, setState) {
                  //             return Platform.isIOS
                  //                 ? CupertinoSwitch(
                  //                     value: showReceipt,
                  //                     onChanged: (bool value) {
                  //                       setState(() {
                  //                         showReceipt = value;
                  //                       });
                  //                     })
                  //                 : Switch(
                  //                     value: showReceipt,
                  //                     onChanged: (bool value) {
                  //                       setState(() {
                  //                         showReceipt = value;
                  //                       });
                  //                     });
                  //           })
                  //         ],
                  //       ),
                  //       const CustomTextSubtitle1(
                  //         text:
                  //             "Let people you're messaging with know when you've seen their messages.",
                  //         color: CColors.secondaryTextLightColor,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // !SECTION

                  // const Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 24.0),
                  //   child: Divider(
                  //     color: CColors.black,
                  //   ),
                  // ),

                  // SECTION Change Password Button
                  GestureDetector(
                    onTap: () => showCustomAlertOptionsDialog(
                        context,
                        "Reset Password",
                        "Are you sure you want to send a password reset email?",
                        "Cancel",
                        null,
                        "Confirm", {
                      FirebaseAuth.instance.sendPasswordResetEmail(
                          email: userProvider.userInfo.email)
                    }),
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
                                CustomTextHeader3(text: "Reset Password"),
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
                  // GestureDetector(
                  //   onTap: () {
                  //     print("notif");
                  //   },
                  //   child: Container(
                  //     color: Colors.transparent,
                  //     padding: const EdgeInsets.symmetric(vertical: 12.0),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Expanded(
                  //           child: Row(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: const [
                  //               Padding(
                  //                 padding: EdgeInsets.only(right: 12.0),
                  //                 child: Icon(
                  //                   CustomIcons.notification,
                  //                   size: 32.0,
                  //                 ),
                  //               ),
                  //               CustomTextHeader3(text: "Notifications"),
                  //             ],
                  //           ),
                  //         ),
                  //         const Icon(
                  //           CustomIcons.right,
                  //           color: CColors.secondaryColor,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
                          const CustomTextSubtitle2(
                            text: "SOON!",
                            color: CColors.secondaryTextLightColor,
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
                      showCupertinoModalPopup(
                          context: context,
                          builder: ((context) => CupertinoPopupSurface(
                                child: Material(
                                    child: SafeArea(
                                  top: false,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16.0),
                                          child: Container(
                                            height: 8.0,
                                            width: 64.0,
                                            decoration: BoxDecoration(
                                                color: CColors.buttonLightColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        32.0)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: width,
                                          child: const Text(
                                            "Are you sure you want to logout?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: CColors
                                                    .primaryTextLightColor,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Inter"),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 24.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: CustomSecondaryButton(
                                              text: "NO",
                                              doOnPressed: () =>
                                                  Navigator.pop(context),
                                            )),
                                            const SizedBox(
                                              width: 12.0,
                                            ),
                                            Expanded(
                                              child: CustomPrimaryButton(
                                                  text: "YES",
                                                  doOnPressed: () async {
                                                    await authVM.logout();
                                                    if (!mounted) return;
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                        builder: (BuildContext
                                                            context) {
                                                          return const LoginScreen();
                                                        },
                                                      ),
                                                      (_) => false,
                                                    );
                                                  }),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                              )));
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
/// !SECTION