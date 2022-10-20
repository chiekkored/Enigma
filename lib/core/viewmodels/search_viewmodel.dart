import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/match_user_model.dart';
import 'package:enigma/core/models/user_model.dart';
import 'package:flutter/foundation.dart';

/// SECTION SearchViewModel
/// SearchViewModel Class
///
/// @author Chiekko Red
class SearchViewModel {
  /// SECTION requestMessageMatch
  /// Function for requesting a message with a user
  ///
  /// @param user Logged in user details
  /// @param chatUser Chat user details
  ///
  /// @author Chiekko Red
  Future<bool> requestMessageMatch(UserModel user, MatchUserModel chatUser) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(chatUser.uid)
        .collection("conversationsList")
        .doc(chatUser.uid)
        .set({
          ...user.toMap(),
          "status": "pending",
          "datetimeCreated": Timestamp.now()
        })
        .then((value) => FirebaseFirestore.instance
                .collection("users")
                .doc(user.uid)
                .collection("conversationsList")
                .doc(chatUser.uid)
                .set({
              "uid": chatUser.uid,
              "chatUserUid": chatUser.uid,
              "status": "waiting",
              "datetimeCreated": Timestamp.now()
            }).then((value) {
              debugPrint("✅ [requestMessageMatch] Success");
              return true;
            }).catchError((err) {
              debugPrint('Error: $err');
              return false;
            }))
        .catchError((err) {
          debugPrint('Error: $err');
          return false;
        });
  }

  /// !SECTION

  /// SECTION requestMessageMatchReject
  /// Function for rejecting a message request
  ///
  /// @param uid Logged in user uid
  /// @param conversationListDoc Conversation List Collection Document
  ///
  /// @author Chiekko Red
  Future<bool> requestMessageMatchReject(String uid,
      QueryDocumentSnapshot<Map<String, dynamic>> conversationListDoc) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("conversationsList")
        .doc(conversationListDoc.id)
        .delete()
        // NOTE Make the rejected user searchable again feature
        // If feature wants to delete the document of waiting
        // in logged in user's end (this results to => user can search a user AGAIN),
        // add logic like get document waiting by conversationListDoc uid
        // then get document id and delete.
        .then((value) {
      debugPrint("✅ [requestMessageMatchReject] Success");
      return true;
    }).catchError((err) {
      debugPrint('Error: $err');
      return false;
    });
  }

  /// !SECTION

  /// SECTION requestMessageMatchAccept
  /// Function for accepting a message request
  ///
  /// @param uid Logged in user uid
  /// @param docId Conversation List Collection Document ID
  /// @param chatUserUid Chat User UID
  ///
  /// @author Chiekko Red
  Future<bool> requestMessageMatchAccept(
      String uid, String docId, String chatUserUid) {
    // NOTE This method gets unique document ID
    final conversationsRef =
        FirebaseFirestore.instance.collection("conversations").doc();

    return FirebaseFirestore.instance
        .collection("conversations")
        .doc(conversationsRef.id)
        .set({"id": conversationsRef.id, "topicName": "All"})
        .then((value) => FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("conversationsList")
            .doc(docId)
            .update({
              "status": "active",
              "id": conversationsRef.id,
              "chatUserUid": chatUserUid
            })
            .then((value) => FirebaseFirestore.instance
                    .collection("users")
                    .doc(chatUserUid)
                    .collection("conversationsList")
                    .doc(chatUserUid)
                    .update({
                  "status": "active",
                  "id": conversationsRef.id,
                }).then((value) {
                  debugPrint("✅ [requestMessageMatchAccept] Success");
                  return true;
                }).catchError((err) {
                  debugPrint('Error: $err');
                  return false;
                }))
            .catchError((err) {
              debugPrint('Error: $err');
              return false;
            }))
        .catchError((err) {
          debugPrint('Error: $err');
          return false;
        });
  }

  /// !SECTION
}

/// !SECTION
