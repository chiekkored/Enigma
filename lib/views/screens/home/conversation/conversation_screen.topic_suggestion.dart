import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tara/core/providers/user_provider.dart';
import 'package:tara/core/viewmodels/conversation_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tara/utilities/constants/themes_constant.dart';
import 'package:tara/views/commons/texts_common.dart';
import 'package:provider/provider.dart';

/// SECTION CoversationScreenTopicSuggestion
/// Conversation Suggestions Button
///
/// @author Chiekko Red
class CoversationScreenTopicSuggestion extends StatelessWidget {
  final String conversationID;
  const CoversationScreenTopicSuggestion(
      {Key? key, required this.conversationID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConversationViewModel conversationVM = ConversationViewModel();
    UserProvider userProvider = context.read<UserProvider>();
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: conversationVM.listenTopicSuggestion(conversationID),
        builder: (context, topicSuggestionSnapshot) {
          if (topicSuggestionSnapshot.hasError) {
            return const CustomTextHeader1(text: "Error");
          }

          if (topicSuggestionSnapshot.hasData) {
            if (topicSuggestionSnapshot.data!.exists) {
              DocumentSnapshot<Map<String, dynamic>> topicSuggestion =
                  topicSuggestionSnapshot.data!;
              return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide.none,
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  onPressed: () => showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return CupertinoPopupSurface(
                          child: Material(
                            child: SafeArea(
                              top: false,
                              child: SizedBox(
                                height: 200.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
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
                                    Expanded(
                                      child: FutureBuilder<
                                              QuerySnapshot<
                                                  Map<String, dynamic>>>(
                                          future: conversationVM
                                              .getTopicMessagesList(
                                                  topicSuggestion["topicName"]),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                              return const CustomTextHeader1(
                                                  text: "Error");
                                            }

                                            if (snapshot.hasData) {
                                              if (snapshot
                                                  .data!.docs.isNotEmpty) {
                                                var data = snapshot
                                                        .data!.docs.first
                                                        .data()[
                                                    "suggestedMessages"];

                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: data.length,
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () => conversationVM
                                                            .sendMessage(
                                                                conversationID,
                                                                userProvider
                                                                    .userInfo
                                                                    .uid,
                                                                data[index]
                                                                    ["message"])
                                                            .then((value) =>
                                                                Navigator.pop(
                                                                    context)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 8.0,
                                                                  horizontal:
                                                                      24.0),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                decoration: BoxDecoration(
                                                                    color: CColors
                                                                        .formColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            32.0)),
                                                                child: CustomTextBody2(
                                                                    text: data[
                                                                            index]
                                                                        [
                                                                        "message"]),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              } else {
                                                return const CustomTextHeader1(
                                                    text: "No Data");
                                              }
                                            } else {
                                              return Center(
                                                child: Platform.isIOS
                                                    ? const CupertinoActivityIndicator(
                                                        color: CColors
                                                            .secondaryColor)
                                                    : const CircularProgressIndicator(
                                                        color: CColors
                                                            .secondaryColor),
                                              );
                                            }
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextHeader3(
                      text: topicSuggestion["topicName"],
                    ),
                  ));
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        });
  }
}
/// !SECTION
