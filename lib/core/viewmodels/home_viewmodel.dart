import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/texts_common.dart';

class HomeViewModel {
  void listenNewMatch(context) {
    bool initialState = false;
    FirebaseFirestore.instance
        .collection("conversation")
        .snapshots()
        .listen((event) {
      if (initialState) {
        for (var change in event.docChanges) {
          if (change.type == DocumentChangeType.added) {
            showCupertinoDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: SafeArea(
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    CColors.buttonLightColor,
                                    CColors.secondaryColor
                                  ])),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 22.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CircleAvatar(
                                  radius: 40.0,
                                  foregroundImage: AssetImage(
                                      "assets/images/onboarding1.png"),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CustomTextSubtitle1(
                                      text: "Red wants to connect with you.",
                                      color: CColors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          TextButton(
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide.none,
                                              backgroundColor:
                                                  Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(32.0),
                                              ),
                                            ),
                                            onPressed: () => {},
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0),
                                              child: CustomTextHeader3(
                                                text: "Reject",
                                                color: CColors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          OutlinedButton(
                                              onPressed: () => {},
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32.0)),
                                              ),
                                              child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 16.0,
                                                      horizontal: 8.0),
                                                  child: const Center(
                                                    child: CustomTextHeader3(
                                                      text: "Accept",
                                                      color: CColors.white,
                                                    ),
                                                  )))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        }
      }
      initialState = true;
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRecentUsers() {
    return FirebaseFirestore.instance
        .collection("conversation")
        .orderBy("datetimeCreated", descending: true)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRecentConversations() {
    return FirebaseFirestore.instance
        .collection("conversation")
        .orderBy("datetimeCreated", descending: true)
        .get();
  }
}
