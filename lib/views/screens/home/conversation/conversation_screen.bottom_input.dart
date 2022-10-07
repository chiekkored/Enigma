import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/conversation_model.dart';
import 'package:enigma/core/models/user_model.dart';
import 'package:enigma/core/providers/conversation_provider.dart';
import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/core/viewmodels/conversation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:giphy_get/giphy_get.dart';
// import 'package:photo_gallery/photo_gallery.dart';

import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/inputs_common.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ConversationScreenBottomInput extends StatefulWidget {
  final UserModel chatUser;
  const ConversationScreenBottomInput({super.key, required this.chatUser});

  @override
  State<ConversationScreenBottomInput> createState() =>
      _ConversationScreenBottomInputState();
}

// List<Album> albumList = [];
// List<Medium> allMedia = [];
bool _isWriting = false;

class _ConversationScreenBottomInputState
    extends State<ConversationScreenBottomInput> {
  TextEditingController chatInputController = TextEditingController();
  bool isTyping = true;

  @override
  Widget build(BuildContext context) {
    ConversationViewModel conversationVM = ConversationViewModel();
    UserProvider userProvider = context.read<UserProvider>();
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
                    if (gif != null) {
                      if (!mounted) return;
                      ConversationModel data = ConversationModel(
                          id: userProvider.userInfo.uid,
                          message: gif.images!.downsized!.url,
                          type: "gif",
                          datetimeCreated: Timestamp.now());
                      context
                          .read<ConversationProvider>()
                          .addMediaConversation(data);

                      conversationVM.uploadFiles(
                          data.message,
                          userProvider.userInfo.uid,
                          "oknqoFfHkUJlGqIgfaOM",
                          Timestamp.now());
                    }
                  }),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Focus(
                    onFocusChange: (value) => setState(() {
                      _isWriting = !value;
                      if (_isWriting) {
                        conversationVM.removeMessageTyping(
                            "oknqoFfHkUJlGqIgfaOM", userProvider.userInfo.uid);
                      }
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
                      onChanged: (value) {
                        if (!_isWriting) {
                          _isWriting = true;
                          conversationVM.sendMessageTyping(
                              "oknqoFfHkUJlGqIgfaOM",
                              userProvider.userInfo.uid);
                        }
                      },
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
                    List<AssetEntity>? mediaList =
                        await AssetPicker.pickAssets(context,
                            pickerConfig: const AssetPickerConfig(
                              themeColor: CColors.secondaryColor,
                            ));
                    if (mediaList != null) {
                      if (mediaList.isNotEmpty) {
                        for (var media in mediaList) {
                          File? file = await media.loadFile();
                          if (!mounted) return;

                          context
                              .read<ConversationProvider>()
                              .addMediaConversation(ConversationModel(
                                  id: "chiekko",
                                  message: file!.path,
                                  type: "image",
                                  datetimeCreated: Timestamp.now()));
                        }
                      }
                    }
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
                // Padding(
                //   padding: const EdgeInsets.only(left: 12.0),
                //   child: GestureDetector(
                //       child: const Icon(
                //         CustomIcons.microphone,
                //         size: 34.0,
                //         color: CColors.secondaryTextLightColor,
                //       ),
                //       onTap: () {}),
                // ),
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
                        String message = chatInputController.text;
                        chatInputController.text = "";
                        _isWriting = false;
                        conversationVM.removeMessageTyping(
                            "oknqoFfHkUJlGqIgfaOM", userProvider.userInfo.uid);
                        conversationVM.sendMessage("oknqoFfHkUJlGqIgfaOM",
                            userProvider.userInfo.uid, message);
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
