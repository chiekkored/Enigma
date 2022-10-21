import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:enigma/core/models/user_model.dart';
import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/core/viewmodels/conversation_viewmodel.dart';
import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/images_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/home/conversation/conversation_screen.bottom_input.dart';
import 'package:enigma/views/screens/home/conversation/conversation_screen.chats.dart';

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
                // NOTE Report User
                case 1:
                  break;
                // NOTE Leave Conversation
                case 2:
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
                                        const Expanded(
                                            child: CustomSecondaryButton(
                                                text: "NO")),
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
              // PopupMenuItem(
              //   value: 1,
              //   child: Row(
              //     children: const [
              //       Icon(Icons.flag_outlined),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Text("Report User")
              //     ],
              //   ),
              // ),
              PopupMenuItem(
                value: 2,
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