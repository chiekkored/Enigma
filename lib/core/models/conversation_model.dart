import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ConversationModel {
  String id;
  String message;
  String type;
  DateTime datetimeCreated;
  ConversationModel({
    required this.id,
    required this.message,
    required this.type,
    required this.datetimeCreated,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'type': type,
      'datetimeCreated': datetimeCreated.millisecondsSinceEpoch,
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      id: map['id'] as String,
      message: map['message'] as String,
      type: map['type'] as String,
      datetimeCreated:
          DateTime.fromMillisecondsSinceEpoch(map['datetimeCreated'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationModel.fromJson(String source) =>
      ConversationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
