import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
/// SECTION UserModel
/// UserModel class
///
/// @author Thomas Rey B Barcenas
class UserModel {
  String uid;
  String displayName;
  String fullName;
  String email;
  String photoURL;
  String school;
  String age;
  String status;
  UserModel({
    this.uid = '',
    this.displayName = '',
    this.fullName = '',
    this.email = '',
    this.photoURL = '',
    this.school = '',
    this.age = '',
    this.status = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'displayName': displayName,
      'fullName': fullName,
      'email': email,
      'photoURL': photoURL,
      'school': school,
      'age': age,
      'status': status,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      displayName: map['displayName'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      photoURL: map['photoURL'] as String,
      school: map['school'] as String,
      age: map['age'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

/// !SECTION
