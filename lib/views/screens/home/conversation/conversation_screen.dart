import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/viewmodels/conversation_viewmodel.dart';
import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/images_common.dart';
import 'package:enigma/views/commons/inputs_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/home/conversation/conversation_screen.bottom_input.dart';
import 'package:enigma/views/screens/home/conversation/conversation_screen.chats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'conversation_screen.topic_suggestion.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    final viewInsets = MediaQuery.of(context).viewInsets;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CColors.primaryTextLightColor,
        centerTitle: false,
        foregroundColor: CColors.secondaryColor,
        titleSpacing: 0,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert),
            offset: const Offset(0, 50),
            onSelected: (value) {
              switch (value) {
                case 1:
                  break;
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
                                              text: "YES", doOnPressed: () {}),
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
                    Icon(Icons.flag_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Report User")
                  ],
                ),
              ),
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
        ],
        title: Row(
          children: const [
            CustomCachedNetworkImage(
                data: "https://i.pravatar.cc/300", radius: 20.0),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: CustomTextHeader3(
                text: "Chiekko",
                color: CColors.trueWhite,
              ),
            )
          ],
        ),
      ),
      body: const ConversationScreenChat(),
      bottomNavigationBar: Padding(
          padding: viewInsets, child: const ConversationScreenBottomInput()),
    );
  }
}
