import 'package:enigma/views/commons/popups_commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel {
  Future<int> signIn(
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
      return 0;
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
        showCustomDialog(context, "Connection Error",
            "Please check connection and try again", "Okay", null);
        debugPrint('No Connection.');
        return 0;
      } else {}
      return 0;
    }
  }
}
