import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/conversation_model.dart';
import 'package:flutter/material.dart';

class ConversationProvider extends ChangeNotifier {
  List<ConversationModel> _conversation = [];

  List<ConversationModel> get getConversation => _conversation;

  void setConversation(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> conversations) {
    _conversation = [];
    for (var conversation in conversations) {
      _conversation.add(ConversationModel.fromMap(conversation.data()));
    }
    // notifyListeners();
  }

  void addMediaConversation(ConversationModel conversation) {
    _conversation.insert(0, conversation);
    notifyListeners();
  }
}
