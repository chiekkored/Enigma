import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

import 'package:enigma/core/models/conversation_model.dart';
import 'package:enigma/core/models/user_model.dart';
import 'package:enigma/core/providers/conversation_provider.dart';
import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/core/viewmodels/conversation_viewmodel.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/images_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/home/conversation/conversation_screen.chats.media.dart';

import 'conversation_screen.topic_list.dart';
import 'conversation_screen.topic_suggestion.dart';

class ConversationScreenChat extends StatelessWidget {
  final UserModel chatUser;
  const ConversationScreenChat({super.key, required this.chatUser});

  @override
  Widget build(BuildContext context) {
    // GroupButtonController _tagSelectedController =
    //     GroupButtonController(selectedIndex: 0);
    // String _selectedTag = "";
    // int _selectedTagIndex = 0;
    ConversationViewModel conversationVM = ConversationViewModel();
    var userProvider = context.read<UserProvider>();
    return Container(
      color: CColors.trueWhite,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: conversationVM.getChatList("oknqoFfHkUJlGqIgfaOM"),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const CustomTextHeader1(text: "Error");
            }

            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Center(
            //     child: Platform.isIOS
            //         ? const CupertinoActivityIndicator(
            //             color: CColors.secondaryColor)
            //         : const CircularProgressIndicator(
            //             color: CColors.secondaryColor),
            //   );
            // }
            if (snapshot.hasData) {
              context
                  .read<ConversationProvider>()
                  .setConversation(snapshot.data!.docs);
              return Column(
                children: [
                  Expanded(
                    child: Listener(
                      onPointerDown: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            if (snapshot.data!.docs.isEmpty) ...[
                              const Align(
                                alignment: Alignment.center,
                                child: CustomTextHeader3(
                                  text:
                                      "Choose a topic or type your own message",
                                  color: CColors.secondaryTextLightColor,
                                ),
                              )
                            ],
                            Consumer<ConversationProvider>(
                                builder: (context, conversations, widget) {
                              return ListView.builder(
                                  reverse: true,
                                  itemCount:
                                      conversations.getConversation.length,
                                  itemBuilder: (context, index) {
                                    ConversationModel conversation =
                                        conversations.getConversation[index];
                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical:
                                                conversation.type == "typing"
                                                    ? 0.0
                                                    : 4.0),
                                        child: chatBubble(conversation,
                                            userProvider.userInfo));
                                  });
                            }),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: CustomTextSubtitle1(
                                        text: "You are now talking about..."),
                                  ),
                                  CoversationScreenTopicSuggestion()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const ConversationScreenTopicList()
                ],
              );
            } else {
              return const CustomTextHeader1(text: "No Data");
            }
          }),
    );
  }

  Widget chatBubble(ConversationModel data, UserModel user) {
    if (data.id == chatUser.uid) {
      switch (data.type) {
        case "gif":
        case "image":
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              bubbleMedia(
                  data, CColors.formColor, CColors.primaryTextLightColor, user),
            ],
          );
        case "typing":
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              bubble(data, CColors.formColor, CColors.secondaryTextLightColor),
            ],
          );
        default:
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              bubble(data, CColors.formColor, CColors.primaryTextLightColor),
            ],
          );
      }
    } else {
      switch (data.type) {
        case "gif":
        case "image":
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              bubbleMedia(
                  data, CColors.primaryTextLightColor, CColors.trueWhite, user),
            ],
          );
        case "typing":
          return Container();
        default:
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              bubble(data, CColors.primaryTextLightColor, CColors.trueWhite),
            ],
          );
      }
    }
  }
}

Container bubble(ConversationModel data, Color color, Color textColor) {
  return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(12.0)),
      child: CustomTextBody2NoOverflow(
        text: data.message,
        color: textColor,
      ));
}

Container bubbleMedia(
    ConversationModel data, Color color, Color textColor, UserModel user) {
  return Container(
      constraints: const BoxConstraints(maxWidth: 280, minWidth: 0.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(12.0)),
      child: Uri.parse(data.message).isAbsolute && data.type != "gif"
          ? CustomCachedNetworkImageSquare(
              data: data.message,
            )
          : ConversationScreenChatsMediaBubble(
              data: data,
              uid: user.uid,
              conversationID: "oknqoFfHkUJlGqIgfaOM"));
}
