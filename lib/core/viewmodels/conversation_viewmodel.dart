import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationViewModel {
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatList(
      String conversationID) {
    return FirebaseFirestore.instance
        .collection("conversations")
        .doc(conversationID)
        .collection("messages")
        .orderBy("datetimeCreated", descending: true)
        .snapshots();
  }

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
        print('Error: $err');
      });
    }
    return true;
  }
}
