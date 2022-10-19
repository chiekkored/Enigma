import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// SECTION NewProfileViewModel
/// NewProfileViewModel Class
///
/// @author Thomas Rey B Barcenas
class NewProfileViewModel {
  /// SECTION updateProfile
  /// Function for updating the profile of a New User
  ///
  /// @param photoURL URL string for the user's avatar
  /// @param displayName string for user's display name
  /// @param fullName string for user's full name
  /// @param age string for user's age
  /// @param school string for user's school
  ///
  /// @author Thomas Rey B Barcenas
  Future<bool> updateProfile(
    String photoURL,
    String displayName,
    String fullName,
    String age,
    String school,
    String uid,
    List<String> academicInterests,
    List<String> sportsInterests,
    List<String> gameInterests,
    List<String> tvShowInterests,
  ) async {
    String imageURL = '';
    FirebaseAuth user = FirebaseAuth.instance;
    DateTime now = DateTime.now();
    final storageRef = FirebaseStorage.instance.ref();
    Reference storageRefPath = storageRef.child('users/$uid/resources/$now');
    Reference storageRefPathSVG =
        storageRef.child('users/$uid/resources/$now.svg');
    List<String> academics =
        academicInterests.map((interest) => interest.toLowerCase()).toList();
    List<String> sports =
        sportsInterests.map((interest) => interest.toLowerCase()).toList();
    List<String> games =
        gameInterests.map((interest) => interest.toLowerCase()).toList();
    List<String> tvShows =
        tvShowInterests.map((interest) => interest.toLowerCase()).toList();
    debugPrint('📚 ${academicInterests.toString()}');
    debugPrint('🏅 ${sportsInterests.toString()}');
    debugPrint('🕹 ${gameInterests.toString()}');
    debugPrint('📺 ${tvShowInterests.toString()}');
    if (school == '') {
      // NOTE only goes through here when schoolTextController.text is empty because school is already populated in the database
      // SECTION Interests
      // Interests inputted by the user is added to their accounts in the database
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.currentUser!.uid)
          .collection('interests')
          .doc('academics')
          .set(
        {"name": "Academics", "interestList": academics},
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.currentUser!.uid)
          .collection('interests')
          .doc('sports')
          .set(
        {"name": "Sports", "interestList": sports},
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.currentUser!.uid)
          .collection('interests')
          .doc('games')
          .set(
        {"name": "Games", "interestList": games},
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.currentUser!.uid)
          .collection('interests')
          .doc('tvShows')
          .set(
        {"name": "TV Shows", "interestList": tvShows},
      );
      // !SECTION
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

      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.currentUser!.uid)
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
    } else {
      // SECTION Interests
      // Interests inputted by the user is added to their accounts in the database
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.currentUser!.uid)
          .collection('interests')
          .add(
        {"name": "Academics", "interestList": academics},
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.currentUser!.uid)
          .collection('interests')
          .add(
        {"name": "Sports", "interestList": sports},
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.currentUser!.uid)
          .collection('interests')
          .add(
        {"name": "Games", "interestList": games},
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.currentUser!.uid)
          .collection('interests')
          .add(
        {"name": "TV Shows", "interestList": tvShows},
      );
      // !SECTION
      // NOTE checks photoURL if it is an SVG file or not
      if (photoURL.split('.').last != 'svg') {
        await storageRefPath.putFile(File(photoURL));
        imageURL = await storageRefPath.getDownloadURL();
      } else {
        const key = "avatar";
        final file =
            await DefaultCacheManager().getSingleFile(photoURL, key: key);
        await storageRefPathSVG.putFile(file);
        imageURL = await storageRefPathSVG.getDownloadURL();
      }
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.currentUser!.uid)
          .update({
            "photoURL": imageURL,
            "displayName": displayName,
            "fullName": fullName,
            "age": age,
            "school": school
          })
          .then((value) => true)
          .catchError((err) {
            debugPrint(err);
            return false;
          });
    }
  }

  // !SECTION
}

/// !SECTION
