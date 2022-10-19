import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/conversation_model.dart';
import 'package:flutter/material.dart';

/// SECTION ConversationProvider
/// ConversationProvider Class
///
/// @author Chiekko Red
class ConversationProvider extends ChangeNotifier {
  /// NOTE Global Variables
  List<ConversationModel> _conversation = [];
  List<ConversationModel> get getConversation => _conversation;

  /// SECTION setConversation
  /// Provider function used in setting the Chat List
  ///
  /// @param conversations List of chats from Firestore
  ///
  /// @author Chiekko Red
  void setConversation(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> conversations) {
    _conversation = [];
    for (var conversation in conversations) {
      _conversation.add(ConversationModel.fromMap(conversation.data()));
    }
    // notifyListeners();
  }

  /// !SECTION

  /// SECTION addMediaConversation
  /// Provider function that adds a temporary media chat before uploading
  ///
  /// @param conversation a conversation chat media
  ///
  /// @author Chiekko Red
  void addMediaConversation(ConversationModel conversation) {
    _conversation.insert(0, conversation);
    notifyListeners();
  }

  /// !SECTION
}
/// !SECTION