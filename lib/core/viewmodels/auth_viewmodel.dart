import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/popups_commons.dart';
import 'package:enigma/views/commons/texts_common.dart';
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
      if (email == '' && password == '') {
        debugPrint('Email & Password is Empty.');
        return 1;
      }
      if (email == '') {
        debugPrint('Email is Empty.');
        return 2;
      }
      if (password == '') {
        debugPrint('Password is Empty.');
        return 3;
      }

      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        debugPrint('Login Successful!');
        showCustomModal(
            context,
            CustomIcons.success_fill,
            CColors.primaryTextLightColor,
            const CustomTextHeader3(text: 'Login Successfully'));
      });
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        return 4;
      } else if (e.code == 'invalid-email') {
        debugPrint('Wrong email provided for that user.');
        return 5;
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        return 6;
      } else if (e.code == 'network-request-failed') {
        showCustomAlertDialog(context, "Connection Error",
            "Please check connection and try again", "Okay", null);
        debugPrint('No Connection.');
        return 0;
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
  Future register(BuildContext context, String email, String password,
      String confirmPassword) async {
    try {
      if (email == '' && password == '') {
        showCustomAlertDialog(context, 'Registration Error',
            'Both Email & Password are\nrequired to register', 'Okay', null);
        debugPrint('Email & Password is Empty.');
        return;
      }
      if (email == '') {
        showCustomAlertDialog(context, 'Registration Error',
            'Email is required to register', 'Okay', null);
        debugPrint('Email is Empty.');
        return;
      }
      if (password == '') {
        showCustomAlertDialog(context, 'Registration Error',
            'Password is required to register', 'Okay', null);
        debugPrint('Password is Empty.');
        return;
      }
      if (email != '' && password != '') {
        if (confirmPassword != password) {
          showCustomAlertDialog(context, 'Registration Error',
              'Passwords do not match', 'Okay', null);
          debugPrint('Passwords do not match');
          return;
        }
      }

      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredentials) async {
        if (!userCredentials.user!.emailVerified) {
          debugPrint('Registration Successful!');
          showCustomModal(
              context,
              CustomIcons.success,
              CColors.onlineColor,
              const CustomTextHeader3(
                  text:
                      'Account successfully created!\nWait for admin confirmation\nemail before you can login\nto your account.'));
          await userCredentials.user!.sendEmailVerification();
        }
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
            'An account is already using the\nemail that was provided',
            'Okay',
            null);
        debugPrint('An account is already using the email that was provided');
      }
    }
  }
}

/// !SECTION
