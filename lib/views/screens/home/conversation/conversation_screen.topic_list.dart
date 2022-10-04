import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class ConversationScreenTopicList extends StatelessWidget {
  const ConversationScreenTopicList({super.key});

  @override
  Widget build(BuildContext context) {
    GroupButtonController _tagSelectedController =
        GroupButtonController(selectedIndex: 0);
    String selectedTag = "";
    int selectedTagIndex = 0;
    return Container(
        color: CColors.scaffoldLightBackgroundColor,
        height: 50.0,
        margin: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 8.0),
                  child: GroupButton(
                    controller: _tagSelectedController,
                    isRadio: true,
                    onSelected: (str, index, isSelected) {
                      selectedTag = str.toString();
                      selectedTagIndex = index;
                    },
                    options: customGroupButtonOptions(),
                    buttons: const [
                      "All",
                      "Food",
                      "Drink",
                      "All",
                      "Food",
                      "Drink"
                    ],
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    BorderRadius.circular(
                                                        32.0)),
                                          ),
                                        ),
                                      ),
                                      const CustomTextHeader2(text: "Topics"),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Center(
                                        child: GroupButton(
                                          controller: _tagSelectedController,
                                          isRadio: true,
                                          onSelected: (str, index, isSelected) {
                                            selectedTag = str.toString();
                                            selectedTagIndex = index;
                                          },
                                          options:
                                              customGroupButtonOptionsFromModal(),
                                          buttons: const [
                                            "All",
                                            "Food",
                                            "Drink",
                                            "All",
                                            "Food",
                                            "Drink"
                                          ],
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
        ));
  }
}
