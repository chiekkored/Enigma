import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:enigma/core/models/user_model.dart';
import 'package:enigma/core/viewmodels/auth_viewmodel.dart';

/// SECTION UserProvider
/// UserProvider Class
///
/// @author Thomas Rey B Barcenas
class UserProvider extends ChangeNotifier {
  /// ANCHOR Global Variables
  final UserModel _user = UserModel();
  UserModel get userInfo => _user;

  /// SECTION setNewUser
  /// Provider function used in Creating a new user
  ///
  /// @param userCredentials data passed in setting up user data in Firestore
  ///
  /// @author Thomas Rey B Barcenas
  Future<void> setNewUser(User userCredentials) async {
    AuthViewModel authVM = AuthViewModel();
    String emailDomain = userCredentials.email!
        .substring(userCredentials.email!.indexOf('@') + 1);
    QuerySnapshot<Map<String, dynamic>> domainCheck = await FirebaseFirestore
        .instance
        .collection('schoolDomains')
        .where('domainName', isEqualTo: emailDomain)
        .limit(1)
        .get();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredentials.uid)
        .set({
      "uid": userCredentials.uid,
      "displayName": userCredentials.email!
          .substring(0, userCredentials.email!.indexOf('@')),
      "email": userCredentials.email,
      "photoURL":
          'https://avatars.dicebear.com/api/adventurer/${userCredentials.email!.substring(0, userCredentials.email!.indexOf('@'))}.svg',
      "status": 'unverified',
      "fullName": '',
      "age": '',
      "school": domainCheck.docs.isNotEmpty
          ? domainCheck.docs.first['schoolName']
          : '',
    }).then((value) async {
      _user.uid = userCredentials.uid;
      _user.displayName = userCredentials.email!
          .substring(0, userCredentials.email!.indexOf('@'));
      _user.email = userCredentials.email ?? '';
      _user.fullName = '';
      _user.age = '';
      _user.photoURL =
          'https://avatars.dicebear.com/api/adventurer/${userCredentials.email!.substring(0, userCredentials.email!.indexOf('@'))}.svg';
      return userCredentials;
    }).then((document) => authVM.setNewPreferences(document));
  }

  /// !SECTION

  /// SECTION setUser
  /// Provider function responsible for setting a sort of "global" usage of the signed in user's credentials
  ///
  /// @param uid UID obtained from the Firestore database of the logged in user
  ///
  /// @author Thomas Rey B Barcenas
  Future<void> setUser(String uid) async {
    AuthViewModel authVM = AuthViewModel();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        _user.uid = documentSnapshot['uid'];
        _user.displayName = documentSnapshot['displayName'];
        _user.email = documentSnapshot['email'];
        _user.photoURL = documentSnapshot['photoURL'];
        _user.school = documentSnapshot['school'];
        _user.fullName = documentSnapshot['fullName'];
        _user.age = documentSnapshot['age'];
        return documentSnapshot;
      }
    }).then((document) => authVM.setPreferences(document!));
  }

  /// SECTION setUser
  /// Provider function responsible for getting user credentials from Local Preferences
  /// Mostly used in switching between apps or closing and opening the app again
  ///
  /// @author Thomas Rey B Barcenas & Chiekko Red
  Future<dynamic> getUserPreference() async {
    return await SharedPreferences.getInstance().then((pref) {
      if (pref.getString('user') != null) {
        final data = jsonDecode(pref.getString('user')!);
        _user.uid = data["uid"];
        _user.email = data["email"];
        _user.displayName = data["displayName"];
        _user.photoURL = data["photoURL"];
        _user.school = data["school"];
        _user.fullName = data["fullName"];
        _user.age = data["age"];
        return data;
      } else {
        return null;
      }
    });
  }

  /// !SECTION

}

/// !SECTION
