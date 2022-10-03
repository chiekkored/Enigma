import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/viewmodels/conversation_viewmodel.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';

import 'conversation_screen.topic_list.dart';
import 'conversation_screen.topic_suggestion.dart';

class ConversationScreenChat extends StatelessWidget {
  const ConversationScreenChat({super.key});

  @override
  Widget build(BuildContext context) {
    GroupButtonController _tagSelectedController =
        GroupButtonController(selectedIndex: 0);
    String _selectedTag = "";
    int _selectedTagIndex = 0;
    ConversationViewModel conversationVM = ConversationViewModel();
    return Container(
      color: CColors.trueWhite,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: conversationVM.getChatList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const CustomTextHeader1(text: "Error");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Platform.isIOS
                  ? const CupertinoActivityIndicator()
                  : const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return Column(
                children: [
                  if (snapshot.data!.docs.isEmpty) ...[
                    const Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomTextHeader3(
                          text: "Choose a topic or type your own message",
                          color: CColors.secondaryTextLightColor,
                        ),
                      ),
                    )
                  ] else ...[
                    Expanded(
                      child: Stack(
                        children: [
                          Listener(
                            onPointerDown: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: ListView.builder(
                                reverse: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  QueryDocumentSnapshot<Map<String, dynamic>>
                                      data = snapshot.data!.docs[index];
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 4.0),
                                      child: chatBubble(data));
                                }),
                          ),
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
                    const ConversationScreenTopicList()
                  ]
                ],
              );
            } else {
              return const CustomTextHeader1(text: "No Data");
            }
          }),
    );
  }

  Row chatBubble(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    switch (data["id"]) {
      case "justin":
        if (data["message"] == "Typing...") {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                      color: CColors.formColor,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: CustomTextBody2(
                    text: data["message"],
                    color: CColors.secondaryTextLightColor,
                  )),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                      color: CColors.formColor,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: CustomTextBody2(
                    text: data["message"],
                    color: CColors.primaryTextLightColor,
                  )),
            ],
          );
        }
      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                decoration: BoxDecoration(
                    color: CColors.primaryTextLightColor,
                    borderRadius: BorderRadius.circular(12.0)),
                child: CustomTextBody2(
                  text: data["message"],
                  color: CColors.trueWhite,
                )),
          ],
        );
    }
  }
}
