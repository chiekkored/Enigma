import 'package:tara/core/providers/user_provider.dart';
import 'package:tara/core/viewmodels/conversation_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tara/core/models/user_model.dart';
import 'package:tara/utilities/configs/custom_icons.dart';
import 'package:tara/utilities/constants/themes_constant.dart';
import 'package:tara/views/commons/buttons_common.dart';
import 'package:tara/views/commons/images_common.dart';
import 'package:tara/views/commons/inputs_common.dart';
import 'package:tara/views/commons/texts_common.dart';
import 'package:tara/views/screens/home/conversation/conversation_screen.bottom_input.dart';
import 'package:tara/views/screens/home/conversation/conversation_screen.chats.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

/// SECTION ConversationScreen
/// Parent widget for Conversation Screen
///
/// @author Chiekko Red
class ConversationScreen extends StatelessWidget {
  final UserModel chatUser;
  final String conversationID;
  final String conversationListID;
  const ConversationScreen(
      {super.key,
      required this.chatUser,
      required this.conversationID,
      required this.conversationListID});

  @override
  Widget build(BuildContext context) {
    List<String> reportReason = [
      "Harassment",
      "Sharing inappropriate things",
      "Hate speech",
      "Scams",
      "Other"
    ];
    String currentReason = reportReason.first;
    bool otherReason = currentReason == "Other" ? true : false;
    TextEditingController otherReasonTextController = TextEditingController();
    double width = MediaQuery.of(context).size.width / 2;
    UserProvider userProvider = context.read<UserProvider>();
    final viewInsets = MediaQuery.of(context).viewInsets;
    ConversationViewModel conversationVM = ConversationViewModel();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: CColors.primaryTextLightColor,
        centerTitle: false,
        foregroundColor: CColors.secondaryColor,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: CColors.secondaryColor,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        actions: [
          // SECTION Settings Dropdown Button
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert),
            offset: const Offset(0, 50),
            onSelected: (value) {
              switch (value) {
                // NOTE Block User
                case 1:
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
                                                color: CColors.dangerColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        32.0)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width,
                                        child: const Text(
                                          "Are you sure you want to block this user?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color:
                                                  CColors.primaryTextLightColor,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Inter"),
                                        ),
                                      ),
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
                                              child: CustomDangerButton(
                                                  text: "YES",
                                                  doOnPressed: () {}),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          )));
                  break;
                // NOTE Report User
                case 2:
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
                                          "What is the reason you are reporting this user?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color:
                                                  CColors.primaryTextLightColor,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Inter"),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: StatefulBuilder(builder:
                                            (BuildContext context,
                                                void Function(void Function())
                                                    setState) {
                                          return DropdownButton<String>(
                                            value: currentReason,
                                            items: reportReason
                                                .map((String reason) {
                                              return DropdownMenuItem<String>(
                                                value: reason,
                                                child: Text(reason),
                                              );
                                            }).toList(),
                                            onChanged: (String? newReason) {
                                              setState(() {
                                                currentReason = newReason!;
                                              });
                                            },
                                          );
                                        }),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 24.0),
                                          child: Expanded(
                                            child: CustomPrimaryButton(
                                                text: "REPORT",
                                                doOnPressed: () {}),
                                          )),
                                    ],
                                  )),
                            ),
                          )));
                  break;
                // NOTE Leave Conversation
                case 3:
                  showCupertinoModalPopup(
                      context: context,
                      builder: ((context) => CupertinoPopupSurface(
                            child: Material(
                                child: SafeArea(
                              top: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                                BorderRadius.circular(32.0)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: width,
                                      child: const Text(
                                        "Are you sure you want leave the conversation?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                CColors.primaryTextLightColor,
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
                                                    Navigator.pop(context))),
                                        const SizedBox(
                                          width: 12.0,
                                        ),
                                        Expanded(
                                          child: CustomPrimaryButton(
                                              text: "YES",
                                              doOnPressed: () {
                                                int count = 0;
                                                conversationVM
                                                    .leaveConversation(
                                                        userProvider.userInfo
                                                            .displayName,
                                                        userProvider
                                                            .userInfo.uid,
                                                        conversationListID,
                                                        conversationID)
                                                    .then(
                                                      (value) =>
                                                          Navigator.of(context)
                                                              .popUntil((_) =>
                                                                  count++ >= 2),
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
                  break;
                default:
                  return;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: const [
                    Icon(
                      Icons.block_outlined,
                      color: CColors.dangerColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Block User",
                        style: TextStyle(color: CColors.dangerColor))
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: const [
                    Icon(
                      Icons.flag_outlined,
                      color: CColors.dangerColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Report User")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: const [
                    Icon(CustomIcons.logout),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Leave Conversation")
                  ],
                ),
              ),
            ],
          ),
          // !SECTION
        ],
        title: Row(
          children: [
            CustomDisplayPhotoURL(photoURL: chatUser.photoURL, radius: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CustomTextHeader3(
                text: chatUser.displayName,
                color: CColors.trueWhite,
              ),
            )
          ],
        ),
      ),
      body: ConversationScreenChat(
        chatUser: chatUser,
        conversationID: conversationID,
      ),
      bottomNavigationBar: Padding(
          padding: viewInsets,
          child: ConversationScreenBottomInput(
              chatUser: chatUser, conversationID: conversationID)),
    );
  }
}
/// !SECTION