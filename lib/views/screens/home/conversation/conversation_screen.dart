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
    final viewInsets = MediaQuery.of(context).viewInsets;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CColors.primaryTextLightColor,
        centerTitle: false,
        foregroundColor: CColors.secondaryColor,
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
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
