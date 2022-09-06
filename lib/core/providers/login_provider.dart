import 'package:enigma/core/models/login_model.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final LoginModel _loginData = LoginModel();

  LoginModel get getLoginData => _loginData;

  void setLoginData(String studentId, String password) {
    _loginData.studentId = studentId;
    _loginData.password = password;

    notifyListeners();
  }
}
