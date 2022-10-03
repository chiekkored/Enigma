import 'package:enigma/views/commons/popups_commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// SECTION AuthViewModel
/// AuthViewModel Class
///
/// @author Thomas Rey B Barcenas
class AuthViewModel {
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
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        debugPrint('Login Successful!');
        return {"status": "success", "return": value.user!.uid};
      });
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        return {"status": "error", "return": 1};
      } else if (e.code == 'invalid-email') {
        debugPrint('Invalid email.');
        return {"status": "error", "return": 2};
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        return {"status": "error", "return": 3};
      } else if (e.code == 'network-request-failed') {
        showCustomAlertDialog(context, "Connection Error",
            "Please check connection and try again", "Okay", null);
        debugPrint('No Connection.');
        return {"status": "error", "return": 4};
      }
    }
  }

  /// !SECTION
  /// SECTION register Function
  /// Function for user registration
  ///
  /// @param context  A handle to the location of a widget in the widget tree.
  /// @param email  String data of the user's email
  /// @param password String data of the user's password'
  ///
  /// @author Thomas Rey B Barcenas
  Future register(BuildContext context, String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredentials) async {
        if (!userCredentials.user!.emailVerified) {
          debugPrint('Registration Successful!');

          // ignore: fixme
          // FIXME We need to manually send the email verification
          // await userCredentials.user!.sendEmailVerification();
        }
        return userCredentials;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showCustomAlertDialog(context, 'Weak Password',
            'The password that was provided is too weak', 'Okay', null);
        debugPrint('The password that was provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        showCustomAlertDialog(
            context,
            'Invalid Email',
            'An account is already using the email that was provided',
            'Okay',
            null);
        debugPrint('An account is already using the email that was provided');
      } else if (e.code == 'network-request-failed') {
        showCustomAlertDialog(context, "Connection Error",
            "Please check connection and try again", "Okay", null);
        debugPrint('No Connection.');
      }
    }
  }

  /// !SECTION

  /// SECTION
  Future<void> logout() async {
    // final pref = await SharedPreferences.getInstance();
    // pref.clear();
    await FirebaseAuth.instance.signOut();
    debugPrint("✅ [logout] Success");
  }

  /// !SECTION
}

/// !SECTION
