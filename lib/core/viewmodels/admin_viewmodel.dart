import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tara/core/viewmodels/profile_viewmodel.dart';

/// View Model for admin settings
class AdminViewModel {
  /// SECTION getUsers
  /// Function for getting all user data
  ///
  /// @param uidList A list of user uid's
  ///
  /// @author Chiekko Red
  Future<List<Map<String, dynamic>>> getUsers(List<String> uidList) async {
    ProfileViewModel profileVM = ProfileViewModel();
    List<Map<String, dynamic>> userData = [];
    for (String uid in uidList) {
      Map<String, dynamic>? user =
          await profileVM.getUser(uid).then((value) => value.data());
      userData.add(user!);
    }
    return userData;
  }

  /// !SECTION

  ///
  /// SECTION banUsers
  /// Function for getting all user data
  ///
  /// @param uidList A list of user uid's
  ///
  /// @author Chiekko Red
  Future<bool> banUsers(List<Map<String, dynamic>> userList) async {
    try {
      for (Map<String, dynamic> user in userList) {
        if (user["value"] == true) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(user["chatUserUid"])
              .update({"status": "banned"});
          FirebaseFirestore.instance
              .collection("reports")
              .doc(user["reportID"])
              .update({"status": "done"});
        }
      }
      debugPrint("✅ [banUsers] Success");
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  /// !SECTION
}
