import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:enigma/core/models/conversation_model.dart';
import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/core/viewmodels/conversation_viewmodel.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';

/// SECTION ConversationScreenChatsMediaBubble
/// Media Chat bubble
/// Gets the temporary media chat then uploads it to Storage and Firestore
///
/// @author Chiekko Red
class ConversationScreenChatsMediaBubble extends StatefulWidget {
  final ConversationModel data;
  final String conversationID;
  final String uid;
  const ConversationScreenChatsMediaBubble(
      {super.key,
      required this.data,
      required this.conversationID,
      required this.uid});

  @override
  State<ConversationScreenChatsMediaBubble> createState() =>
      _ConversationScreenChatsMediaBubbleState();
}

class _ConversationScreenChatsMediaBubbleState
    extends State<ConversationScreenChatsMediaBubble> {
  ConversationViewModel conversationVM = ConversationViewModel();
  ValueNotifier<double> progress = ValueNotifier<double>(0.0);
  @override
  void initState() {
    super.initState();
    if (widget.data.type != "gif") uploadMedia();
  }

  /// SECTION uploadMedia
  /// Uploads the temporary media to Storage and add it to Firestore
  void uploadMedia() async {
    UserProvider userProvider = context.read<UserProvider>();
    final storageRef = FirebaseStorage.instance.ref();
    Timestamp now = Timestamp.now();

    final uploadTask = storageRef
        .child(
            "users/${userProvider.userInfo.uid}/resources/messages/${widget.conversationID}/${now.microsecondsSinceEpoch}")
        .putFile(File(widget.data.message));

    // NOTE Listens to upload events and display running upload progress
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          progress.value =
              (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          break;
        case TaskState.paused:
          debugPrint("Upload is paused.");
          break;
        case TaskState.canceled:
          debugPrint("Upload was canceled");
          break;
        case TaskState.error:
          debugPrint("Upload error");
          break;
        case TaskState.success:
          String imageUrl = await taskSnapshot.ref.getDownloadURL();
          // NOTE Add to Firestore
          conversationVM.uploadFiles(
              imageUrl, userProvider.userInfo.uid, widget.conversationID, now);
          break;
      }
    });
  }

  /// !SECTION

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // NOTE If type is image or not image (Gif URL)
        widget.data.type == "image"
            ? Image.file(File(widget.data.message))
            : Image.network(widget.data.message),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: ValueListenableBuilder<double>(
              valueListenable: progress,
              builder: (context, value, _) {
                return CircularProgressIndicator(
                  value: value,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      CColors.secondaryColor),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    progress.dispose();
    super.dispose();
  }
}
/// !SECTION