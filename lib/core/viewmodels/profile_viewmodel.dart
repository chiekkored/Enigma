import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// SECTION HomeViewModel
/// Profile View Model Class
///
/// @author Chiekko Red
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
        .get()
        .then((value) {
      debugPrint("✅ [getUserInterests] Success");
      return value;
    }).catchError((err) {
      debugPrint('Error: $err');
    });
  }

  /// !SECTION

  /// SECTION updateUserProfile
  /// Function for updating the profile of the User
  ///
  /// @param photoURL URL string for the user's avatar
  /// @param displayName string for user's display name
  /// @param fullName string for user's full name
  /// @param age string for user's age
  /// @param uid string for the user's UID
  /// @param academicInterests list string of the user's academic interests
  /// @param sportsInterests list string of the user's sports interests
  /// @param gameInterests list string of the user's game interests
  /// @param tvShowInterests list string of the user's tv show interests
  ///
  /// @author Thomas Rey B Barcenas
  Future<bool> updateUserProfile(
    String photoURL,
    String displayName,
    String fullName,
    String age,
    String uid,
    List<dynamic> academicInterests,
    List<dynamic> sportsInterests,
    List<dynamic> gameInterests,
    List<dynamic> tvShowInterests,
  ) async {
    final storageRef = FirebaseStorage.instance.ref();
    var userCollection =
        FirebaseFirestore.instance.collection('users').doc(uid);
    DateTime now = DateTime.now();
    String imageURL = '';
    List<dynamic> academics =
        academicInterests.map((interest) => interest.toLowerCase()).toList();
    List<dynamic> sports =
        sportsInterests.map((interest) => interest.toLowerCase()).toList();
    List<dynamic> games =
        gameInterests.map((interest) => interest.toLowerCase()).toList();
    List<dynamic> tvShows =
        tvShowInterests.map((interest) => interest.toLowerCase()).toList();
    Reference storageRefPath = storageRef.child('users/$uid/resources/$now');
    Reference storageRefPathSVG =
        storageRef.child('users/$uid/resources/$now.svg');
    debugPrint('📚 ${academicInterests.toString()}');
    debugPrint('🏅 ${sportsInterests.toString()}');
    debugPrint('🕹 ${gameInterests.toString()}');
    debugPrint('📺 ${tvShowInterests.toString()}');

    // SECTION interests section
    userCollection
        .collection('interests')
        .doc('academics')
        .update({"interestList": academics});
    userCollection
        .collection('interests')
        .doc('sports')
        .update({"interestList": sports});
    userCollection
        .collection('interests')
        .doc('games')
        .update({"interestList": games});
    userCollection
        .collection('interests')
        .doc('tvShows')
        .update({"interestList": tvShows});

    // !SECTION
    if (photoURL != '') {
      // NOTE checks photoURL if it is an SVG file or not
      if (photoURL.split('.').last != 'svg') {
        await storageRefPath.putFile(File(photoURL));
        imageURL = await storageRefPath.getDownloadURL();
      } else {
        const key = "avatar";
        final file =
            await DefaultCacheManager().getSingleFile(photoURL, key: key);
        await storageRefPathSVG.putFile(
            file,
            SettableMetadata(
              contentType: "image/svg+xml",
            ));
        DefaultCacheManager().removeFile(key);
        imageURL = await storageRefPathSVG.getDownloadURL();
      }

      return userCollection
          .update({
            "photoURL": imageURL,
            "displayName": displayName,
            "fullName": fullName,
            "age": age,
          })
          .then((value) => true)
          .catchError((err) {
            debugPrint(err);
            return false;
          });
    }

    return userCollection
        .update({
          "displayName": displayName,
          "fullName": fullName,
          "age": age,
        })
        .then((value) => true)
        .catchError((err) {
          debugPrint(err);
          return false;
        });
  }

  // !SECTION
}
  /// !SECTION
