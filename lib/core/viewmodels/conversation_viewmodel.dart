import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/conversation_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_manager/src/types/entity.dart';

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
      List<AssetEntity> mediaList, String uid, String conversationID) async {
    for (var media in mediaList) {
      String imageUrl = "";
      DateTime now = DateTime.now();
      print(await media.loadFile());

      File? filePath = await media.loadFile();
      if (await filePath!.exists()) {
        final storageRef = FirebaseStorage.instance.ref();
        // FIXME Temporary, must put the chatmate id in address
        Reference storageRefDest =
            storageRef.child("users/$uid/resources/messages/$now");
        await storageRefDest.putFile(filePath);
        imageUrl = await storageRefDest.getDownloadURL();

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
    }
    return true;
  }
}
