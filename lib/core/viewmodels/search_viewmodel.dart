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
}
