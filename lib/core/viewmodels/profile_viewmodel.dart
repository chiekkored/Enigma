import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileViewModel {
  /// SECTION getUserInterests
  /// Function for getting user interests
  ///
  /// @param uid Logged in user's uid
  ///
  /// @author Chiekko Red
  Future<QuerySnapshot<Map<String, dynamic>>> getUserInterests(String uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("interests")
        .get();
  }

  /// !SECTION
}
