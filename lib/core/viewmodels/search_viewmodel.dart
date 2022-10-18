import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/match_user_model.dart';

class SearchViewModel {
  Future<bool> requestMessageMatch(MatchUserModel matchUser, String chatUid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(chatUid)
        .collection("conversationsList")
        .add({
          ...matchUser.toMap(),
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
