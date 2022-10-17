import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// SECTION ConversationViewModel
/// Conversation View Model Class
///
/// @author Chiekko Red
class ConversationViewModel {
  /// SECTION getChatList
  /// Function for getting all conversation chats
  ///
  /// @param conversationID An ID string for the conversation document ID
  ///
  /// @author Chiekko Red
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatList(
      String conversationID) {
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
        })
        .then((value) => true)
        .catchError((err) {
          print('Error: $err');
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
        })
        .then((value) => true)
        .catchError((err) {
          print('Error: $err');
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
        .then((value) => true)
        .catchError((err) {
      print('Error: $err');
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
      }).catchError((err) {
        debugPrint('Error: $err');
      });
    }
    return true;
  }

  /// !SECTION

  /// SECTION getTopicSuggestion
  /// Function for listening topic suggestion
  ///
  /// @param conversationID An ID string for the conversation document ID
  ///
  /// @author Chiekko Red
  Stream<QuerySnapshot<Map<String, dynamic>>> getTopicSuggestion(
      String conversationID) {
    return FirebaseFirestore.instance
        .collection("conversations")
        .where("id", isEqualTo: conversationID)
        .limit(1)
        .snapshots();
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
        .update({"topic": topicName})
        .then((value) => true)
        .catchError((err) {
          print('Error: $err');
          return false;
        });
  }

  /// !SECTION

  /// SECTION getTopicSuggestionList
  /// Function for listening topic suggestion list
  ///
  /// @param conversationID An ID string for the conversation document ID
  /// @param topicName The name of the topic
  ///
  /// @author Chiekko Red
  Future<QuerySnapshot<Map<String, dynamic>>> getTopicSuggestionList(
      String conversationID) {
    return FirebaseFirestore.instance.collection("topics").get();
  }

  /// !SECTION

  /// SECTION getTopicMessagesList
  /// Function for getting topic messages
  ///
  /// @param conversationID An ID string for the conversation document ID
  /// @param topicName The name of the topic
  ///
  /// @author Chiekko Red
  Future<QuerySnapshot<Map<String, dynamic>>> getTopicMessagesList(
      String topicName) {
    return FirebaseFirestore.instance
        .collection("topics")
        .where("name", isEqualTo: topicName)
        .limit(1)
        .get();
  }

  /// !SECTION
}
