import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/inputs_common.dart';
import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';

class ConversationScreenBottomInput extends StatefulWidget {
  const ConversationScreenBottomInput({super.key});

  @override
  State<ConversationScreenBottomInput> createState() =>
      _ConversationScreenBottomInputState();
}

class _ConversationScreenBottomInputState
    extends State<ConversationScreenBottomInput> {
  bool isTyping = true;

  @override
  Widget build(BuildContext context) {
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
                      context: context, //Required
                      apiKey: "Ms2tAgp7uMxtqloXOlqdpGd07efy7gio", //Required.
                      lang: GiphyLanguage
                          .english, //Optional - Language for query.
                      tabColor: Colors.teal, // Optional- default accent color.
                    );
                    print(gif!);
                  }),
              Expanded(
                child: SizedBox(
                  height: 55.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Focus(
                      onFocusChange: (value) => setState(() {
                        isTyping = !value;
                      }),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: customSmallInputDecoration(
                            hintText: "Message",
                            hintTextColor: CColors.strokeColor,
                            fillColor: CColors.trueWhite),
                      ),
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
                    onTap: () {}),
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
                        color: CColors.secondaryTextLightColor,
                      ),
                      onTap: () {}),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
