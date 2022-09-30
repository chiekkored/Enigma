import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/user_model.dart';
// import 'package:enigma/core/viewmodels/auth_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final UserModel _user = UserModel();
  UserModel get userInfo => _user;

  Future<void> setNewUser(User userCredentials) async {
    // AuthViewModel _authVM = AuthViewModel();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredentials.uid)
        .set({
      "uid": userCredentials.uid,
      "displayName": userCredentials.email!
          .substring(0, userCredentials.email!.indexOf('@')),
      "email": userCredentials.email,
      "photoURL": userCredentials.photoURL ?? 'https://via.placeholder.com/150',
    }).then((value) async {
      _user.uid = userCredentials.uid;
      _user.displayName = userCredentials.displayName!
          .substring(0, userCredentials.email!.indexOf('@'));
      _user.email = userCredentials.email ?? '';
      _user.photoURL =
          userCredentials.photoURL ?? 'https://via.placeholder.com/150';
      return userCredentials;
    });
  }
}
