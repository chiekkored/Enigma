import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/conversation_model.dart';
import 'package:enigma/core/viewmodels/search_viewmodel.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/popups_commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'package:enigma/core/models/user_model.dart';
import 'package:enigma/core/viewmodels/home_viewmodel.dart';
import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/images_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/home/conversation/conversation_screen.dart';

/// SECTION ChatScreen
/// ChatScreen Class
///
/// @author Chiekko Red
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth user = FirebaseAuth.instance;
    HomeViewModel homeVM = HomeViewModel();
    SearchViewModel searchVM = SearchViewModel();
    homeVM.listenNewMatch(context, user.currentUser!.uid);
    double width = MediaQuery.of(context).size.width / 1.5;
    return Container(
      color: CColors.scaffoldLightBackgroundColor,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SECTION Pending matches user list
                Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: SizedBox(
                    height: 108.0,
                    // NOTE Get Pending List
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: homeVM
                            .listenPendingMatchList(user.currentUser!.uid),
                        builder: (context, recentUsers) {
                          if (recentUsers.hasError) {
                            debugPrint("❌ [PendingMatchList] Error");
                            return const CustomTextHeader1(text: "Error");
                          }

                          if (recentUsers.hasData) {
                            debugPrint("🟢 [PendingMatchList] Done");
                            if (recentUsers.data!.docs.isNotEmpty) {
                              debugPrint("🗂 [PendingMatchList] Has Data");
                              return ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28.0),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: recentUsers.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    QueryDocumentSnapshot<Map<String, dynamic>>
                                        conversationListDoc =
                                        recentUsers.data!.docs[index];
                                    // SECTION User Details
                                    // NOTE Listen to User Details
                                    return StreamBuilder<
                                            DocumentSnapshot<
                                                Map<String, dynamic>>>(
                                        stream: homeVM.listenUserDetails(
                                            conversationListDoc["uid"]),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return const CustomTextHeader1(
                                                text: "Error");
                                          }

                                          if (snapshot.hasData) {
                                            if (snapshot.data!.exists) {
                                              UserModel chatUser =
                                                  UserModel.fromMap(snapshot
                                                          .data!
                                                          .data()
                                                      as Map<String, dynamic>);
                                              // SECTION List widget
                                              return pendingMatchList(
                                                  context,
                                                  chatUser,
                                                  searchVM,
                                                  user,
                                                  conversationListDoc);
                                              // !SECTION
                                            } else {
                                              // SECTION Empty User Details
                                              return const CustomTextHeader1(
                                                text: "No Data",
                                                color: CColors
                                                    .secondaryTextLightColor,
                                              );
                                              // !SECTION
                                            }
                                          } else {
                                            // SECTION Loading User Details
                                            return Center(
                                              child: Platform.isIOS
                                                  ? const CupertinoActivityIndicator(
                                                      color: CColors
                                                          .secondaryColor)
                                                  : const CircularProgressIndicator(
                                                      color: CColors
                                                          .secondaryColor),
                                            );
                                            // !SECTION
                                          }
                                        });
                                    // !SECTION
                                  });
                            } else {
                              debugPrint("📭 [PendingMatchList] No Data");
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 24.0),
                                  child: CustomTextHeader3(
                                    text: "No Pending Requests",
                                    color: CColors.secondaryTextLightColor,
                                  ),
                                ),
                              );
                            }
                          } else {
                            debugPrint("⏳ [PendingMatchList] Waiting");
                            return Center(
                              child: Platform.isIOS
                                  ? const CupertinoActivityIndicator(
                                      color: CColors.secondaryColor)
                                  : const CircularProgressIndicator(
                                      color: CColors.secondaryColor),
                            );
                          }
                        }),
                  ),
                ),
                // !SECTION

                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: CustomTextHeader1(text: "Recent Conversations"),
                ),

                // SECTION Conversation list
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 24.0),
                  // NOTE Get Recent Conversation list
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: homeVM
                          .listenRecentConversationsList(user.currentUser!.uid),
                      builder: (context, recentConversation) {
                        if (recentConversation.hasError) {
                          debugPrint("❌ [RecentConversationsList] Error");
                          return const CustomTextHeader1(text: "Error");
                        }

                        if (recentConversation.hasData) {
                          debugPrint("🟢 [RecentConversationsList] Done");
                          if (recentConversation.data!.docs.isNotEmpty) {
                            debugPrint("🗂 [RecentConversationsList] Has Data");
                            return ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                shrinkWrap: true,
                                itemCount: recentConversation.data!.docs.length,
                                itemBuilder: (context, index) {
                                  QueryDocumentSnapshot<Map<String, dynamic>>
                                      conversationListDoc =
                                      recentConversation.data!.docs[index];
                                  // SECTION User Details
                                  // NOTE Listen to User Details
                                  return StreamBuilder<
                                          DocumentSnapshot<
                                              Map<String, dynamic>>>(
                                      stream: homeVM.listenUserDetails(
                                          conversationListDoc["uid"]),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return const CustomTextHeader1(
                                              text: "Error");
                                        }

                                        if (snapshot.hasData) {
                                          if (snapshot.data!.exists) {
                                            UserModel chatUser =
                                                UserModel.fromMap(snapshot.data!
                                                        .data()
                                                    as Map<String, dynamic>);
                                            // SECTION List widget
                                            return conversationList(
                                                context,
                                                chatUser,
                                                conversationListDoc,
                                                homeVM,
                                                width);
                                            // !SECTION
                                          } else {
                                            // SECTION Empty User Details
                                            return const CustomTextHeader1(
                                              text: "No Data",
                                              color: CColors
                                                  .secondaryTextLightColor,
                                            );
                                            // !SECTION
                                          }
                                        } else {
                                          // SECTION Loading User Details
                                          return Center(
                                            child: Platform.isIOS
                                                ? const CupertinoActivityIndicator(
                                                    color:
                                                        CColors.secondaryColor)
                                                : const CircularProgressIndicator(
                                                    color:
                                                        CColors.secondaryColor),
                                          );
                                          // !SECTION
                                        }
                                      });
                                  // !SECTION
                                });
                          } else {
                            // SECTION Empty Recent Conversation
                            debugPrint("📭 [RecentConversationsList] No Data");
                            return Container();
                            // !SECTION
                          }
                        } else {
                          // SECTION Loading Recent Conversation
                          debugPrint("⏳ [RecentConversationsList] Waiting");
                          return Center(
                            child: Platform.isIOS
                                ? const CupertinoActivityIndicator(
                                    color: CColors.secondaryColor)
                                : const CircularProgressIndicator(
                                    color: CColors.secondaryColor),
                          );
                          // !SECTION
                        }
                      }),
                )
                // !SECTION
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector conversationList(
      BuildContext context,
      UserModel chatUser,
      QueryDocumentSnapshot<Map<String, dynamic>> conversationListDoc,
      HomeViewModel homeVM,
      double width) {
    return GestureDetector(
      onTap: () => pushNewScreen(context,
          screen: ConversationScreen(
              chatUser: chatUser,
              conversationID: conversationListDoc["id"],
              conversationListID: conversationListDoc.id),
          withNavBar: false),
      child: Slidable(
        ///ANCHOR - Slidable Leave Conversation Feature
        // endActionPane: ActionPane(
        //   motion: const ScrollMotion(),
        //   children: [
        //     SlidableAction(
        //       onPressed: (_) => {},
        //       backgroundColor: CColors.buttonLightColor,
        //       foregroundColor: Colors.white,
        //       icon: CustomIcons.logout,
        //       label: 'Leave',
        //     ),
        //   ],
        // ),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDisplayPhotoURL(
                      photoURL: chatUser.photoURL, radius: 45.0),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextBody2(
                          text: "${chatUser.displayName}, ${chatUser.age}"),
                      const SizedBox(
                        height: 8.0,
                      ),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: homeVM
                              .listenRecentMessage(conversationListDoc["id"]),
                          builder: (context, message) {
                            if (message.hasData &&
                                message.data!.docs.isNotEmpty) {
                              ConversationModel messageData =
                                  ConversationModel.fromMap(
                                      message.data!.docs.first.data());
                              return SizedBox(
                                width: width,
                                child: Uri.parse(messageData.message).isAbsolute
                                    ? CustomTextHeader2Italic(
                                        text:
                                            "${messageData.id == chatUser.uid ? "${chatUser.displayName} has" : "You"} sent a media file.")
                                    : CustomTextHeader2(
                                        text: messageData.message),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ],
                  ),
                ],
              ),
              // Align(
              //   alignment:
              //       Alignment.bottomRight,
              //   child: Padding(
              //     padding:
              //         const EdgeInsets.only(
              //             right: 14.0),
              //     child: CustomTextSubtitle1(
              //       text: timeago.format(
              //           data['datetimeCreated']
              //               .toDate(),
              //           locale: 'en_short'),
              //       color: CColors
              //           .secondaryTextLightColor,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector pendingMatchList(
      BuildContext context,
      UserModel chatUser,
      SearchViewModel searchVM,
      FirebaseAuth user,
      QueryDocumentSnapshot<Map<String, dynamic>> conversationListDoc) {
    return GestureDetector(
      onTap: () => showCupertinoDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                decoration: BoxDecoration(
                  color: CColors.trueWhite,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomDisplayPhotoURL(
                          photoURL: chatUser.photoURL, radius: 60.0),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextHeader2(
                            text: chatUser.displayName,
                          ),
                          CustomTextSubtitle1(
                            text: ", ${chatUser.age}",
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CustomSecondaryButton(
                                  text: "Reject",
                                  doOnPressed: () => searchVM
                                      .requestMessageMatchReject(
                                          user.currentUser!.uid,
                                          conversationListDoc)
                                      .then((value) => Navigator.pop(context)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CustomPrimaryButton(
                                  text: "Accept",
                                  doOnPressed: () => searchVM
                                      .requestMessageMatchAccept(
                                          user.currentUser!.uid,
                                          conversationListDoc.id,
                                          chatUser.uid)
                                      .then((value) => Navigator.pop(context)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      child: Padding(
        padding: const EdgeInsets.only(right: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomDisplayPhotoURL(photoURL: chatUser.photoURL, radius: 40.0),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomTextBody2(
                  text: "${chatUser.displayName}, ${chatUser.age}"),
            )
          ],
        ),
      ),
    );
  }
}

///!SECTION
