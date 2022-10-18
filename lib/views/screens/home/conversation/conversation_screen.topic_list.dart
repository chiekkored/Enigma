import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/viewmodels/conversation_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/texts_common.dart';

/// SECTION ConversationScreenTopicList
/// List of topics widget
///
/// @author Chiekko Red
class ConversationScreenTopicList extends StatelessWidget {
  final String conversationID;
  const ConversationScreenTopicList({Key? key, required this.conversationID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConversationViewModel conversationVM = ConversationViewModel();
    GroupButtonController tagSelectedController = GroupButtonController();
    String selectedTag = "All";
    late Iterable<String> topicList;

    onSelected(str, index, isSelected) async {
      selectedTag = str.toString();
      // tagSelectedController.selectIndex(index);
      await conversationVM.setTopicSuggestion(conversationID, selectedTag);
    }

    return Container(
        color: CColors.scaffoldLightBackgroundColor,
        height: 50.0,
        margin: const EdgeInsets.only(top: 8.0),
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: conversationVM.getTopicSuggestionList(conversationID),
            builder: (context, topicListSnapshot) {
              if (topicListSnapshot.hasError) {
                return const CustomTextHeader1(text: "Error");
              }

              if (topicListSnapshot.hasData) {
                if (topicListSnapshot.data!.docs.isNotEmpty) {
                  topicList =
                      topicListSnapshot.data!.docs.map((e) => e.data()["name"]);
                  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: conversationVM
                          .getTopicSuggestionSelected(conversationID),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.exists) {
                            tagSelectedController.selectIndex(topicList
                                .toList()
                                .indexWhere((element) =>
                                    element ==
                                    snapshot.data!.data()!["topicName"]));
                          }
                        }
                        return Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: GroupButton(
                                    controller: tagSelectedController,
                                    isRadio: true,
                                    onSelected: onSelected,
                                    options: customGroupButtonOptions(),
                                    buttons: topicList.toList(),
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () => showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoPopupSurface(
                                            child: Material(
                                              child: SafeArea(
                                                top: false,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 24.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      16.0),
                                                          child: Container(
                                                            height: 8.0,
                                                            width: 64.0,
                                                            decoration: BoxDecoration(
                                                                color: CColors
                                                                    .buttonLightColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            32.0)),
                                                          ),
                                                        ),
                                                      ),
                                                      const CustomTextHeader2(
                                                          text: "Topics"),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      Center(
                                                        child: GroupButton(
                                                          controller:
                                                              tagSelectedController,
                                                          isRadio: true,
                                                          onSelected:
                                                              onSelected,
                                                          options:
                                                              customGroupButtonOptionsFromModal(),
                                                          buttons: topicList
                                                              .toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                    child: const CustomTextHeader3(
                                      text: "SHOW",
                                      color: CColors.secondaryColor,
                                    ),
                                  ),
                                )),
                          ],
                        );
                      });
                } else {
                  return Container();
                }
              } else {
                return Center(
                  child: Platform.isIOS
                      ? const CupertinoActivityIndicator(
                          color: CColors.secondaryColor)
                      : const CircularProgressIndicator(
                          color: CColors.secondaryColor),
                );
              }
            }));
  }
}
/// !SECTION