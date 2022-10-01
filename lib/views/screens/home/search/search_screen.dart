import 'dart:async';

import 'package:enigma/views/screens/home/conversation/conversation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/images_common.dart';
import 'package:enigma/views/commons/inputs_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  double? bottomModal;
  late StreamSubscription<bool> keyboardSubscription;
  @override
  void initState() {
    super.initState();
    // NOTE Listen to keyboard visiblity
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      // NOTE If keyboard is visible, open modal to full height
      if (visible) {
        setState(() {
          bottomModal = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // SECTION Grid design configuration
    var crossAxisSpacing = 25;
    var screenWidth = MediaQuery.of(context).size.width;
    var crossAxisCount = 2;
    var width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    var cellHeight = 250;
    var aspectRatio = width / cellHeight;
    // !SECTION
    return Scaffold(
      // SECTION Sticky Bottom Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            left: 24.0, right: 24.0, bottom: 26.0, top: 8.0),
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: CustomTextHeader3(
              text: "Search again",
              color: CColors.white,
            ),
          ),
        ),
      ),
      // !SECTION
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                // SECTION Filter Button
                child: GestureDetector(
                  // SECTION Bottom Sheet Modal
                  onTap: () => showModalBottomSheet(
                    context: context,
                    isDismissible: false,
                    isScrollControlled: true,
                    builder: ((context) => CupertinoPopupSurface(
                          child: Material(
                            child: FractionallySizedBox(
                              heightFactor: bottomModal,
                              child: Container(
                                color: CColors.trueWhite,
                                padding: const EdgeInsets.all(24.0),
                                width: screenWidth,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SECTION Filter Title
                                    const Center(
                                        child:
                                            CustomTextHeader1(text: "Filter")),
                                    // !SECTION
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        // SECTION Filter Title
                                        CustomTextHeader2(
                                          text: "Add your interests",
                                          color:
                                              CColors.secondaryTextLightColor,
                                        ),
                                        // !SECTION

                                        // SECTION Clear Button
                                        CustomTextHeader3(
                                          text: "Clear",
                                          color: CColors.secondaryColor,
                                        )
                                        // !SECTION
                                      ],
                                    ),

                                    // SECTION Filter List
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: CustomTextHeader2(
                                        text: "Academics",
                                        color: CColors.secondaryTextLightColor,
                                      ),
                                    ),
                                    // SECTION Filter Interest Lists Input
                                    const CustomTextFieldTags(
                                      hintText: "academics",
                                    ),
                                    // !SECTION
                                    // !SECTION

                                    // SECTION Cancel and Apply Button
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomSecondaryButton(
                                              text: "Cancel",
                                              doOnPressed: () {
                                                bottomModal = null;
                                                Navigator.pop(context);
                                              }),
                                        ),
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                        Expanded(
                                          child: CustomPrimaryButton(
                                              text: "Apply",
                                              doOnPressed: () {}),
                                        ),
                                      ],
                                    )
                                    // !SECTION
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                  // !SECTION

                  // SECTION Filter Button Icon
                  child: const Icon(CustomIcons.filter),
                ),
              ),
              // !SECTION
              // !SECTION

              // SECTION Title text
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 26.0, top: 18.0),
                  child: CustomTextHeader1(text: "Matches your interests"),
                ),
              ),
              // !SECTION

              // SECTION Matched Users Grid
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 25.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: aspectRatio,
                  ),
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => pushNewScreen(context,
                          screen: const ConversationScreen()),
                      child: Column(
                        children: const [
                          CustomCachedNetworkImage(
                              data: "https://i.pravatar.cc/300", radius: 50.0),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: CustomTextBody2(text: "Chiekko, 22"),
                          )
                        ],
                      ),
                    );
                  })
              // !SECTION
            ],
          ),
        )),
      ),
    );
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }
}
