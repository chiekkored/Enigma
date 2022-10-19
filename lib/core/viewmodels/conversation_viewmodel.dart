import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// SECTION ConversationViewModel
/// Conversation View Model Class
///
/// @author Chiekko Red
class ConversationViewModel {
  /// SECTION listenChatList
  /// Function for listening all conversation chats
  ///
  /// @param conversationID An ID string for the conversation document ID
  ///
  /// @author Chiekko Red
  Stream<QuerySnapshot<Map<String, dynamic>>> listenChatList(
      String conversationID) {
    debugPrint("🔈 [listenChatList] Listening");
    return FirebaseFirestore.instance
        .collection("conversations")
        .doc(conversationID)
        .collection("messages")
        .orderBy("datetimeCreated", descending: true)
        .snapshots();
  }

  /// !SECTION

  /// SECTION sendMessageTyping
  /// Function for creating a typing chat
  ///
  /// @param conversationID An ID string for the conversation document ID
  /// @param uid Logged in user's uid
  ///
  /// @author Chiekko Red
  Future<bool> sendMessageTyping(String conversationID, String uid) {
    return FirebaseFirestore.instance
        .collection("conversations")
        .doc(conversationID)
        .collection("messages")
        .doc("typing-$uid")
        .set({
      "datetimeCreated": DateTime.now(),
      "id": uid,
      "message": "Typing...",
      "type": "typing"
    }).then((value) {
      debugPrint("✅ [sendMessageTyping] Success");
      return true;
    }).catchError((err) {
      debugPrint('Error: $err');
      return false;
    });
  }

  /// !SECTION

  /// SECTION sendMessage
  /// Function for sending the chat
  ///
  /// @param conversationID An ID string for the conversation document ID
  /// @param uid Logged in user's uid
  /// @param message User's message
  ///
  /// @author Chiekko Red
  Future<bool> sendMessage(String conversationID, String uid, String message) {
    return FirebaseFirestore.instance
        .collection("conversations")
        .doc(conversationID)
        .collection("messages")
        .add({
      "datetimeCreated": DateTime.now(),
      "id": uid,
      "message": message,
      "type": "text"
    }).then((value) {
      debugPrint("✅ [sendMessage] Success");
      return true;
    }).catchError((err) {
      debugPrint('Error: $err');
      return false;
    });
  }

  /// !SECTION

  /// SECTION removeMessageTyping
  /// Function for removing the typing chat
  ///
  /// @param conversationID An ID string for the conversation document ID
  /// @param uid Logged in user's uid
  ///
  /// @author Chiekko Red
  Future<bool> removeMessageTyping(String conversationID, String uid) {
    return FirebaseFirestore.instance
        .collection("conversations")
        .doc(conversationID)
        .collection("messages")
        .doc("typing-$uid")
        .delete()
        .then((value) {
      debugPrint("✅ [removeMessageTyping] Success");
      return true;
    }).catchError((err) {
      debugPrint('Error: $err');
      return false;
    });
  }

  /// !SECTION

  /// SECTION uploadFiles
  /// Function for sending a chat media
  ///
  /// @param imageUrl The URL link for the media from Firebase Storage
  /// @param uid Logged in user's uid
  /// @param conversationID An ID string for the conversation document ID
  /// @param now Date and time now for datetimeCreated field in Firestore
  ///
  /// @author Chiekko Red
  Future<bool> uploadFiles(
      String imageUrl, String uid, String conversationID, Timestamp now) async {
    if (imageUrl != "") {
      FirebaseFirestore.instance
          .collection("conversations")
          .doc(conversationID)
          .collection("messages")
          .add({
        "id": uid,
        "message": imageUrl,
        "type": "image",
        "datetimeCreated": now
      }).then((value) {
        debugPrint("✅ [uploadFiles] Success");
        return true;
      }).catchError((err) {
        debugPrint('Error: $err');
      });
    }
    return true;
  }

  /// !SECTION

  /// SECTION listenTopicSuggestion
  /// Function for listening topic suggestion
  ///
  /// @param conversationID An ID string for the conversation document ID
  ///
  /// @author Chiekko Red
  Stream<DocumentSnapshot<Map<String, dynamic>>> listenTopicSuggestion(
      String conversationID) {
    debugPrint("🔈 [listenTopicSuggestion] Listening");
    return FirebaseFirestore.instance
        .collection("conversations")
        .doc(conversationID)
        .snapshots();
  }

  /// !SECTION

  /// SECTION getTopicSuggestionSelected
  /// Function for getting topic suggestion active
  ///
  /// @param conversationID An ID string for the conversation document ID
  ///
  /// @author Chiekko Red
  Future<DocumentSnapshot<Map<String, dynamic>>> getTopicSuggestionSelected(
      String conversationID) {
    return FirebaseFirestore.instance
        .collection("conversations")
        .doc(conversationID)
        .get()
        .then((value) {
      debugPrint("✅ [getTopicSuggestionSelected] Success");
      return value;
    });
  }

  /// !SECTION

  /// SECTION getTopicSuggestion
  /// Function for listening topic suggestion
  ///
  /// @param conversationID An ID string for the conversation document ID
  /// @param topicName The name of the topic
  ///
  /// @author Chiekko Red
  Future<bool> setTopicSuggestion(String conversationID, String topicName) {
    return FirebaseFirestore.instance
        .collection("conversations")
        .doc(conversationID)
        .update({"topicName": topicName}).then((value) {
      debugPrint("✅ [setTopicSuggestion] Success");
      return true;
    }).catchError((err) {
      debugPrint('Error: $err');
      return false;
    });
  }

  /// !SECTION

  /// SECTION getTopicSuggestionList
  /// Function for listening topic suggestion list
  ///
  /// @param conversationID An ID string for the conversation document ID
  ///
  /// @author Chiekko Red
  Future<QuerySnapshot<Map<String, dynamic>>> getTopicSuggestionList(
      String conversationID) {
    return FirebaseFirestore.instance.collection("topics").get().then((value) {
      debugPrint("✅ [getTopicSuggestionList] Success");
      return value;
    });
  }

  /// !SECTION

  /// SECTION getTopicMessagesList
  /// Function for getting topic messages
  ///
  /// @param topicName The name of the topic
  ///
  /// @author Chiekko Red
  Future<QuerySnapshot<Map<String, dynamic>>> getTopicMessagesList(
      String topicName) {
    return FirebaseFirestore.instance
        .collection("topics")
        .where("name", isEqualTo: topicName)
        .limit(1)
        .get()
        .then((value) {
      debugPrint("✅ [getTopicMessagesList] Success");
      return value;
    });
  }

  /// !SECTION

  /// SECTION getTopicMessagesList
  /// Function for leaving Conversation
  ///
  /// @param displayName The name of the user that left the chat
  /// @param uid Logged in user's uid
  /// @param conversationListID Conversation List Document ID (users/{userid}/conversationsList/{DocID})
  /// @param conversationID Conversation Document ID (conversations/{DocID})
  ///
  /// @author Chiekko Red
  Future<bool> leaveConversation(String displayName, String uid,
      String conversationListID, String conversationID) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("conversationsList")
        .doc(conversationListID)
        .update({"status": "leave"})
        .then((value) => FirebaseFirestore.instance
                .collection("conversations")
                .doc(conversationID)
                .collection("messages")
                .doc("leave-$uid")
                .set({
              "datetimeCreated": DateTime.now(),
              "id": uid,
              "message": "$displayName has left the chat.",
              "type": "leave"
            }).then((value) {
              debugPrint("✅ [leaveConversation] Success");
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
}

/// !SECTION
