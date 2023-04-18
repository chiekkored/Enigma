import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tara/core/models/user_model.dart';

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

  /// SECTION blockUser
  /// Function for blocking a user
  ///
  /// @param uid Logged in user's uid
  /// @param chatUser Chat user model
  /// @param conversationListID Conversation List Document ID (users/{userid}/conversationsList/{DocID})
  /// @param conversationID Conversation Document ID (conversations/{DocID})
  ///
  /// @author Chiekko Red
  Future<bool> blockUser(String uid, UserModel chatUser,
      String conversationListID, String conversationID) async {
    try {
      DateTime now = DateTime.now();
      // Add document to logged in user
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection("blocking")
          .doc(chatUser.uid)
          .set({"dateCreated": now, "profileUid": chatUser.uid});
      // Add document to blocked user
      await FirebaseFirestore.instance
          .collection('users')
          .doc(chatUser.uid)
          .collection("blocker")
          .doc(uid)
          .set({"dateCreated": now, "profileUid": uid});
      // Delete the conversation from user
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection("conversationsList")
          .doc(conversationListID)
          .delete();
      // Delete the conversation from the chat User
      await FirebaseFirestore.instance
          .collection('users')
          .doc(chatUser.uid)
          .collection("conversationsList")
          .doc(conversationListID)
          .delete();
      // Delete the document of the conversation
      await FirebaseFirestore.instance
          .collection('conversations')
          .doc(conversationID)
          .delete();
      debugPrint("✅ [blockUser] Success");
      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  /// !SECTION

  /// SECTION reportUser
  /// Function for reporting a user with reason
  ///
  /// @param uid Logged in user's uid
  /// @param chatUser Chat user model
  /// @param conversationListID Conversation List Document ID (users/{userid}/conversationsList/{DocID})
  /// @param conversationID Conversation Document ID (conversations/{DocID})
  /// @param reason The reason for reporting a user
  ///
  /// @author Chiekko Red
  Future<bool> reportUser(String uid, UserModel chatUser,
      String conversationListID, String conversationID, String reason) async {
    try {
      DateTime now = DateTime.now();
      CollectionReference reportsCollection =
          FirebaseFirestore.instance.collection('reports');
      String docId = reportsCollection.doc().id;

      // Add document to blocked user
      await reportsCollection.doc(docId).set({
        "dateCreated": now,
        "userUid": uid,
        "chatUserUid": chatUser.uid,
        "conversationListID": conversationListID,
        "conversationID": conversationID,
        "reason": reason,
        "status": "pending"
      });
      debugPrint("✅ [blockUser] Success");
      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  /// !SECTION
}

/// !SECTION
