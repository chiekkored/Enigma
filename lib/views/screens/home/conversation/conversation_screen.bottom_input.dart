import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tara/core/models/conversation_model.dart';
import 'package:tara/core/models/user_model.dart';
import 'package:tara/core/providers/conversation_provider.dart';
import 'package:tara/core/providers/user_provider.dart';
import 'package:tara/core/viewmodels/conversation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:giphy_get/giphy_get.dart';

import 'package:tara/utilities/configs/custom_icons.dart';
import 'package:tara/utilities/constants/themes_constant.dart';
import 'package:tara/views/commons/inputs_common.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

/// SECTION ConversationScreenBottomInput
/// The widget for chat input field and attachments section
///
/// @author Chiekko Red
class ConversationScreenBottomInput extends StatefulWidget {
  final UserModel chatUser;
  final String conversationID;
  const ConversationScreenBottomInput(
      {super.key, required this.chatUser, required this.conversationID});

  @override
  State<ConversationScreenBottomInput> createState() =>
      _ConversationScreenBottomInputState();
}

class _ConversationScreenBottomInputState
    extends State<ConversationScreenBottomInput> {
  final ImagePicker picker = ImagePicker();
  TextEditingController chatInputController = TextEditingController();
  bool isTyping = true;
  bool _isWriting = false;

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
              // SECTION GIF Button
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
                          widget.conversationID,
                          Timestamp.now());
                    }
                  }),
              // !SECTION

              // SECTION Chat Input Field
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Focus(
                    onFocusChange: (value) => setState(() {
                      _isWriting = !value;
                      if (_isWriting) {
                        conversationVM.removeMessageTyping(
                            widget.conversationID, userProvider.userInfo.uid);
                      }
                      isTyping = !value;
                    }),
                    child: TextField(
                      controller: chatInputController,
                      autofocus: true,
                      textCapitalization: TextCapitalization.sentences,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: const TextStyle(fontSize: 16.0),
                      decoration: customSmallInputDecoration(
                          hintText: "Message",
                          hintTextColor: CColors.strokeColor,
                          fillColor: CColors.trueWhite),
                      onChanged: (value) {
                        if (!_isWriting) {
                          _isWriting = true;
                          conversationVM.sendMessageTyping(
                              widget.conversationID, userProvider.userInfo.uid);
                        }
                      },
                    ),
                  ),
                ),
              ),
              // !SECTION

              // SECTION Attachment Section
              // NOTE If user not typing, change to attachment button
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
                    // List<AssetEntity>? mediaList =
                    //     await AssetPicker.pickAssets(context,
                    //         pickerConfig: const AssetPickerConfig(
                    //           requestType: RequestType.image,
                    //           themeColor: CColors.secondaryColor,
                    //         ));
                    final List<XFile> images = await picker.pickMultiImage();
                    // if (images != null) {
                    if (images.isNotEmpty) {
                      for (var media in images) {
                        // File? file = await media.loadFile();
                        if (!mounted) return;

                        // NOTE Add media temporarily to Chat Provider Array
                        // LINK ./conversation_screen.chats.media.dart
                        context
                            .read<ConversationProvider>()
                            .addMediaConversation(ConversationModel(
                                id: "chiekko",
                                message: media.path,
                                type: "image",
                                datetimeCreated: Timestamp.now()));
                      }
                    }
                    // }
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
                // NOTE If user is typing, change to send button
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
                        if (chatInputController.text != "") {
                          String message = chatInputController.text;
                          chatInputController.text = "";
                          _isWriting = false;
                          conversationVM.removeMessageTyping(
                              widget.conversationID, userProvider.userInfo.uid);
                          conversationVM.sendMessage(widget.conversationID,
                              userProvider.userInfo.uid, message);
                        }
                      }),
                ),
                // !SECTION
              ]
            ],
          ),
        ),
      ),
    );
  }
}
/// !SECTION