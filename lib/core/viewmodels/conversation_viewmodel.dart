import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/conversation_model.dart';
import 'package:enigma/core/providers/conversation_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/src/types/entity.dart';
import 'package:provider/provider.dart';

class ConversationViewModel {
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatList() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc("cUvJbIdhETeHraTsR31I")
        .collection("conversations")
        .doc("hq0OUYZbpLGJ3aDAG28p")
        .collection("messages")
        .orderBy("datetimeCreated", descending: true)
        .snapshots();
  }

  Future<bool> uploadFiles(
      String imageUrl, String uid, String conversationID, Timestamp now) async {
    if (imageUrl != "") {
      FirebaseFirestore.instance
          .collection("users")
          .doc("cUvJbIdhETeHraTsR31I")
          .collection("conversations")
          .doc(conversationID)
          .collection("messages")
          .add({
        "id": "chiekko",
        "message": imageUrl,
        "type": "image",
        "datetimeCreated": now
      }).catchError((err) {
        print('Error: $err');
      });
    }
    print("object2");
    return true;
  }
}
