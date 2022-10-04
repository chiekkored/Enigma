import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
/// SECTION UserModel
/// UserModel class
///
/// @author Thomas Rey B Barcenas
class UserModel {
  String uid;
  String displayName;
  String email;
  String photoURL;
  UserModel({
    this.uid = '',
    this.displayName = '',
    this.email = '',
    this.photoURL = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      displayName: map['displayName'] as String,
      email: map['email'] as String,
      photoURL: map['photoURL'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

/// !SECTION
