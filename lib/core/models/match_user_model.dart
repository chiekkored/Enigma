// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MatchUserModel {
  final String uid;
  final String displayName;
  final String fullName;
  final String email;
  final String photoURL;
  final String school;
  final String age;
  final int score;
  MatchUserModel({
    required this.uid,
    required this.displayName,
    required this.fullName,
    required this.email,
    required this.photoURL,
    required this.school,
    required this.age,
    required this.score,
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
      'score': score,
    };
  }

  factory MatchUserModel.fromMap(Map<String, dynamic> map) {
    return MatchUserModel(
      uid: map['uid'] as String,
      displayName: map['displayName'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      photoURL: map['photoURL'] as String,
      school: map['school'] as String,
      age: map['age'] as String,
      score: map['score'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MatchUserModel.fromJson(String source) =>
      MatchUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
