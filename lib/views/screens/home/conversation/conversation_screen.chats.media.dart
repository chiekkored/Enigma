import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/conversation_model.dart';
import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/core/viewmodels/conversation_viewmodel.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    // TODO: implement initState
    super.initState();
    if (widget.data.type != "gif") uploadMedia();
  }

  void uploadMedia() async {
    UserProvider userProvider = context.read<UserProvider>();
    final storageRef = FirebaseStorage.instance.ref();
    Timestamp now = Timestamp.now();
    print(widget.data.message);
    // FIXME Temporary, must put the chatmate id in address
    final uploadTask = storageRef
        .child(
            "users/${userProvider.userInfo.uid}/resources/messages/${now.microsecondsSinceEpoch}")
        .putFile(File(widget.data.message));
    // final uploadTask = await storageRefDest;
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          // final progress =
          //     100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          progress.value =
              (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          String imageUrl = await taskSnapshot.ref.getDownloadURL();
          conversationVM.uploadFiles(
              imageUrl, userProvider.userInfo.uid, widget.conversationID, now);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
