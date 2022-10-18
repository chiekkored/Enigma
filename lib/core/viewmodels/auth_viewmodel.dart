import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/views/commons/popups_commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SECTION AuthViewModel
/// AuthViewModel Class
///
/// @author Thomas Rey B Barcenas
class AuthViewModel {
  /// SECTION setPreferences Function
  /// Function for setting user in local storage FROM FIRESTORE
  ///
  /// @param document A DocumentSnapshot that contains user data
  ///
  /// @author Chiekko Red
  Future<void> setPreferences(DocumentSnapshot document) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(
        'user',
        jsonEncode({
          "uid": document["uid"],
          "email": document["email"],
          "displayName": document["displayName"],
          "photoURL": document["photoURL"],
          "school": document["school"],
          "fullName": document["fullName"],
          "age": document["age"]
        }));
    debugPrint("✅ [setPreferences] Success");
  }

  // !SECTION
  /// SECTION setNewPreferences Function
  /// Function for setting user in local storage FROM USER INPUT
  ///
  /// @param document A DocumentSnapshot that contains user data
  ///
  /// @author Chiekko Red
  Future<void> setNewPreferences(User user) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(
        'user',
        jsonEncode({
          "uid": user.uid,
          "email": user.email ?? "",
          "displayName": user.displayName ?? "",
          "photoURL": user.photoURL ?? "",
          "school": "",
          "fullName": "",
          "age": ""
        }));
    debugPrint("✅ [setNewPreferences] Success");
  }

  // !SECTION
  /// SECTION signIn Function
  /// Function for sign-in authentication
  ///
  /// @param context  A handle to the location of a widget in the widget tree.
  /// @param email  String data of the user's email
  /// @param password String data of the user's password'
  ///
  /// @author Thomas Rey B Barcenas
  Future<dynamic> signIn(
      BuildContext context, String email, String password) async {
    try {
      // NOTE proceeds to this code block after checking user status is 'verified'
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        QuerySnapshot<Map<String, dynamic>> user = await FirebaseFirestore
            .instance
            .collection('users')
            .where("email", isEqualTo: email)
            .limit(1)
            .get();
        if (user.docs.first['status'] == 'banned') {
          debugPrint('👿 User is banned');
          return {"status": "error", "return": 4};
        } else if (user.docs.first['status'] == 'unverified') {
          debugPrint('👿 User is not verified');
          return {"status": "unverified", "return": user.docs.first.id};
        } else if (user.docs.first['fullName'] == '') {
          debugPrint('✅ New User Login Successful!');
          return {"status": "newUser", "return": value.user!.uid};
        }
        debugPrint('✅ Login Successful!');
        return {"status": "success", "return": value.user!.uid};
      });

      // NOTE error catchers
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'user-not-found') {
        debugPrint('👿 No user found for that email.');
        return {"status": "error", "return": 1};
      } else if (e.code == 'invalid-email') {
        debugPrint('👿 Invalid email.');
        return {"status": "error", "return": 2};
      } else if (e.code == 'wrong-password') {
        debugPrint('👿 Wrong password provided for that user.');
        return {"status": "error", "return": 3};
      } else if (e.code == 'network-request-failed') {
        showCustomAlertDialog(context, "Connection Error",
            "Please check connection and try again", "Okay", null);
        debugPrint('👿 No Connection.');
        // NOTE {"return": 0} is only for error messages that use showCustomAlertDialog
        return {"status": "error", "return": 0};
      }
    }
  }

  /// !SECTION
  /// SECTION register Function
  /// Function for user registration
  ///
  /// @param context A handle to the location of a widget in the widget tree.
  /// @param email  String data of the user's email
  /// @param password String data of the user's password'
  ///
  /// @author Thomas Rey B Barcenas
  Future register(BuildContext context, String email, String password) async {
    try {
      String emailDomain = email.substring(email.indexOf('@') + 1);
      return FirebaseAuth.instance.signInAnonymously().then((value) async {
        debugPrint('✅ Signed in anonymously');
        // NOTE obtains list of banned email domains and checks the domain given by the user
        QuerySnapshot<Map<String, dynamic>> domainCheck =
            await FirebaseFirestore.instance
                .collection('bannedDomains')
                .where('domainName', isEqualTo: emailDomain)
                .get();
        debugPrint('👿 This email domain is banned');
        await FirebaseAuth.instance.signOut();
        if (domainCheck.docs.isNotEmpty) {
          return 'banned';
        } else {
          // NOTE proceeds to this code block if the email domain given isnt on the ban list
          return await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((userCredentials) async {
            if (!userCredentials.user!.emailVerified) {
              debugPrint('✅ Registration Successful!');
              // ignore: fixme
              // FIXME We need to manually send the email verification
              // await userCredentials.user!.sendEmailVerification();
            }
            return userCredentials;
          });
        }
      });

      // NOTE error catchers
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showCustomAlertDialog(context, 'Weak Password',
            'The password that was provided is too weak', 'Okay', null);
        debugPrint('👿 The password that was provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        showCustomAlertDialog(
            context,
            'Invalid Email',
            'An account is already using the email that was provided',
            'Okay',
            null);
        debugPrint(
            '👿 An account is already using the email that was provided');
      } else if (e.code == 'network-request-failed') {
        showCustomAlertDialog(context, "Connection Error",
            "Please check connection and try again", "Okay", null);
        debugPrint('👿 No Connection.');
      }
    }
  }

  /// !SECTION
  /// SECTION logout
  /// Function for user logout
  ///
  /// @author Thomas Rey B Barcenas
  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    await FirebaseAuth.instance.signOut();
    debugPrint("✅ [logout] Success");
  }

  /// !SECTION
}

/// !SECTION
