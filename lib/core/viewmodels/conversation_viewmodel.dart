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
    // .collection("users")
    // .doc(uid)
    // .collection("conversations")
    // .doc("hq0OUYZbpLGJ3aDAG28p")
    // .collection("messages")
    // .orderBy("datetimeCreated", descending: true)
    // .snapshots();
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
