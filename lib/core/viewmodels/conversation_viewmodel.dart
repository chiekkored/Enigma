import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationViewModel {
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatList() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc("cUvJbIdhETeHraTsR31I")
        .collection("conversations")
        .doc("hq0OUYZbpLGJ3aDAG28p")
        .collection("messages")
        .orderBy("datetimeCreated", descending: true)
        .snapshots();
  }
}
