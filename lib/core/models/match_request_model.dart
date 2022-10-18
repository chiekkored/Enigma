// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MatchRequestModel {
  String uid;
  String displayName;
  String fullName;
  String email;
  String photoURL;
  String school;
  String age;
  String status;
  Timestamp datetimeCreated;
  MatchRequestModel({
    required this.uid,
    required this.displayName,
    required this.fullName,
    required this.email,
    required this.photoURL,
    required this.school,
    required this.age,
    required this.status,
    required this.datetimeCreated,
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
      'datetimeCreated': datetimeCreated,
    };
  }

  factory MatchRequestModel.fromMap(Map<String, dynamic> map) {
    return MatchRequestModel(
      uid: map['uid'] as String,
      displayName: map['displayName'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      photoURL: map['photoURL'] as String,
      school: map['school'] as String,
      age: map['age'] as String,
      status: map['status'] as String,
      datetimeCreated: map['datetimeCreated'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory MatchRequestModel.fromJson(String source) =>
      MatchRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
