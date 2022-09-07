// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginModel {
  String studentId;
  String password;
  LoginModel({
    this.studentId = '',
    this.password = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studentId': studentId,
      'password': password,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      studentId: map['studentId'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
