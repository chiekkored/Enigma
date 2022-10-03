import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoversationScreenTopicSuggestion extends StatelessWidget {
  const CoversationScreenTopicSuggestion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Container(
                                height: 8.0,
                                width: 64.0,
                                decoration: BoxDecoration(
                                    color: CColors.buttonLightColor,
                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 3,
                                padding: const EdgeInsets.all(0),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 24.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              color: CColors.formColor,
                                              borderRadius:
                                                  BorderRadius.circular(32.0)),
                                          child: CustomTextBody2(
                                              text:
                                                  "Do you play any sports? $index"),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomTextHeader3(
            text: "text",
          ),
        ));
  }
}
