import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/match_request_model.dart';
import 'package:enigma/views/commons/images_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/texts_common.dart';

/// SECTION HomeViewModel
/// Home View Model Class
///
/// @author Chiekko Red
class HomeViewModel {
  /// SECTION listenNewMatch
  /// Function for listening new pending chat match
  ///
  /// @param context A handle to the location of a widget in the widget tree.
  /// @param uid Logged in user's uid
  ///
  /// @author Chiekko Red
  void listenNewMatch(context, String uid) {
    bool initialState = false;
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("conversationsList")
        .where("status", isEqualTo: "pending")
        .orderBy("datetimeCreated", descending: true)
        .limit(1)
        .snapshots()
        .listen((event) {
      if (initialState) {
        int index = 0;
        for (var change in event.docChanges) {
          if (change.type == DocumentChangeType.added) {
            MatchRequestModel data =
                MatchRequestModel.fromMap(event.docs[index].data());
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
                                CustomDisplayPhotoURL(
                                    photoURL: data.photoURL, radius: 40.0),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextHeader2(
                                          text: data.displayName,
                                          color: CColors.white,
                                        ),
                                        CustomTextSubtitle1(
                                          text: ", ${data.age}",
                                          color: CColors.white,
                                        ),
                                      ],
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
            index++;
          }
        }
      }
      initialState = true;
    });
  }

  /// !SECTION

  /// SECTION getRecentUsersList
  /// Function for listening recent users
  ///
  /// @param uid Logged in user's uid
  ///
  /// @author Chiekko Red
  Stream<QuerySnapshot<Map<String, dynamic>>> getRecentUsersList(String uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("conversationsList")
        .where("status", isEqualTo: "active")
        // .orderBy("datetimeCreated", descending: true)
        .snapshots();
  }

  /// !SECTION

  /// SECTION getRecentConversationsList
  /// Function for listening the conversation chats
  ///
  /// @param uid Logged in user's uid
  ///
  /// @author Chiekko Red
  Stream<QuerySnapshot<Map<String, dynamic>>> getRecentConversationsList(
      String uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("conversationsList")
        .where("status", isEqualTo: "active")
        // .orderBy("datetimeCreated", descending: true)
        .snapshots();
  }

  /// !SECTION

  /// SECTION getConversationDetails
  /// Function for getting the user details
  ///
  /// @param chatUserUid Chat user's uid
  ///
  /// @author Chiekko Red
  Future<DocumentSnapshot<Map<String, dynamic>>> getConversationDetails(
      String chatUserUid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(chatUserUid)
        .get();
  }

  /// !SECTION

  /// SECTION getRecentMessage
  /// Function for listening the last message received
  ///
  /// @param conversationID An ID string for the conversation document ID
  ///
  /// @author Chiekko Red
  Stream<QuerySnapshot<Map<String, dynamic>>> getRecentMessage(
      String conversationID) {
    return FirebaseFirestore.instance
        .collection("conversations")
        .doc(conversationID)
        .collection("messages")
        .orderBy("datetimeCreated", descending: true)
        .limit(1)
        .snapshots();
  }

  /// !SECTION
}

/// !SECTION
