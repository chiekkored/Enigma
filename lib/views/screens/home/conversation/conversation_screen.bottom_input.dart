import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/views/commons/images_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:giphy_get/giphy_get.dart';
// import 'package:photo_gallery/photo_gallery.dart';

import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/inputs_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'conversation_screen.local_images.dart';

class ConversationScreenBottomInput extends StatefulWidget {
  const ConversationScreenBottomInput({super.key});

  @override
  State<ConversationScreenBottomInput> createState() =>
      _ConversationScreenBottomInputState();
}

// List<Album> albumList = [];
// List<Medium> allMedia = [];

class _ConversationScreenBottomInputState
    extends State<ConversationScreenBottomInput> {
  TextEditingController chatInputController = TextEditingController();
  bool isTyping = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        color: CColors.scaffoldLightBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Icon(
                      Icons.gif_box_outlined,
                      size: 34.0,
                      color: CColors.secondaryTextLightColor,
                    ),
                  ),
                  onTap: () async {
                    GiphyGif? gif = await GiphyGet.getGif(
                      context: context,
                      apiKey: dotenv.env['GIPHY_API_KEY'].toString(),
                      lang: GiphyLanguage.english,
                      tabColor: CColors.buttonLightColor,
                    );
                  }),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Focus(
                    onFocusChange: (value) => setState(() {
                      isTyping = !value;
                    }),
                    child: TextField(
                      controller: chatInputController,
                      autofocus: true,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: customSmallInputDecoration(
                          hintText: "Message",
                          hintTextColor: CColors.strokeColor,
                          fillColor: CColors.trueWhite),
                    ),
                  ),
                ),
              ),
              if (isTyping) ...[
                GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Icon(
                      CustomIcons.attachment,
                      size: 34.0,
                      color: CColors.secondaryTextLightColor,
                    ),
                  ),
                  onTap: () async {
                    List<AssetEntity>? pickedList =
                        await AssetPicker.pickAssets(context,
                            pickerConfig: const AssetPickerConfig(
                              themeColor: CColors.secondaryColor,
                            ));
                  },
                  // onTap: () => showCupertinoModalPopup(
                  //     context: context,
                  //     builder: (context) {
                  //       return CupertinoPopupSurface(
                  //         child: Material(
                  //           child: SafeArea(
                  //               top: false,
                  //               child: SizedBox(
                  //                 width: width,
                  //                 child: Column(
                  //                   mainAxisSize: MainAxisSize.min,
                  //                   children: const [
                  //                     Padding(
                  //                       padding: EdgeInsets.symmetric(
                  //                           vertical: 16.0),
                  //                       child:
                  //                           CustomTextHeader2(text: "Source"),
                  //                     ),
                  //                     ConversationScreenLocalImagesList()
                  //                   ],
                  //                 ),
                  //               )),
                  //         ),
                  //       );
                  //     }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: GestureDetector(
                      child: const Icon(
                        CustomIcons.microphone,
                        size: 34.0,
                        color: CColors.secondaryTextLightColor,
                      ),
                      onTap: () {}),
                ),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: GestureDetector(
                      child: const Icon(
                        CustomIcons.send,
                        size: 34.0,
                        color: CColors.secondaryColor,
                      ),
                      onTap: () async {
                        CollectionReference userConversation = FirebaseFirestore
                            .instance
                            .collection('users')
                            .doc("cUvJbIdhETeHraTsR31I")
                            .collection("conversations")
                            .doc("hq0OUYZbpLGJ3aDAG28p")
                            .collection("messages");
                        String chatText = chatInputController.text;
                        chatInputController.text = "";
                        await userConversation.add({
                          "datetimeCreated": DateTime.now(),
                          "id": "justin",
                          "message": chatText
                        });
                      }),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
