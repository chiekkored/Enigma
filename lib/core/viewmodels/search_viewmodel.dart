import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/user_model.dart';

class SearchViewModel {
  Future<bool> requestMessageMatch(UserModel user, String chatUid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(chatUid)
        .collection("conversationsList")
        .add({
          ...user.toMap(),
          "status": "pending",
          "datetimeCreated": Timestamp.now()
        })
        .then((value) => true)
        .catchError((err) {
          print('Error: $err');
          return false;
        });
  }

  Future<bool> requestMessageMatchReject(String uid, String docId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("conversationsList")
        .doc(docId)
        .delete()
        .then((value) => true)
        .catchError((err) {
      print('Error: $err');
      return false;
    });
  }

  Future<bool> requestMessageMatchAccept(
      String uid, String docId, String chatUserUid) {
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
                .add({
                  "status": "active",
                  "id": conversationsRef.id,
                  "chatUserUid": uid
                })
                .then((value) => true)
                .catchError((err) {
                  print('Error: $err');
                  return false;
                }))
            .catchError((err) {
              print('Error: $err');
              return false;
            }))
        .catchError((err) {
          print('Error: $err');
          return false;
        });
  }
}
