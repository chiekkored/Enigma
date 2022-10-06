import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/user_model.dart';
import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/views/commons/images_common.dart';
import 'package:enigma/views/screens/home/conversation/conversation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:enigma/core/viewmodels/home_viewmodel.dart';
import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/onboarding/entry_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth user = FirebaseAuth.instance;
    HomeViewModel homeVM = HomeViewModel();
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomTextHeader1(text: "Recent Conversations"),
                ),

                // SECTION Horizontal scroll user list
                Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: SizedBox(
                    height: 108.0,
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream:
                            homeVM.getRecentUsersList(user.currentUser!.uid),
                        builder: (context, recentUsers) {
                          if (recentUsers.hasError) {
                            return const CustomTextHeader1(text: "Error");
                          }

                          if (recentUsers.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Platform.isIOS
                                  ? const CupertinoActivityIndicator(
                                      color: CColors.secondaryColor)
                                  : const CircularProgressIndicator(
                                      color: CColors.secondaryColor),
                            );
                          }
                          if (recentUsers.hasData) {
                            if (recentUsers.data!.docs.isNotEmpty) {
                              return ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28.0),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: recentUsers.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    QueryDocumentSnapshot<Map<String, dynamic>>
                                        conversationListDoc =
                                        recentUsers.data!.docs[index];
                                    return FutureBuilder<
                                            DocumentSnapshot<
                                                Map<String, dynamic>>>(
                                        future: homeVM.getConversationDetails(
                                            conversationListDoc["chatUserUid"]),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return const CustomTextHeader1(
                                                text: "Error");
                                          }

                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child: Platform.isIOS
                                                  ? const CupertinoActivityIndicator(
                                                      color: CColors
                                                          .secondaryColor)
                                                  : const CircularProgressIndicator(
                                                      color: CColors
                                                          .secondaryColor),
                                            );
                                          }
                                          if (snapshot.hasData) {
                                            if (snapshot.data!.exists) {
                                              UserModel chatUser =
                                                  UserModel.fromMap(snapshot
                                                          .data!
                                                          .data()
                                                      as Map<String, dynamic>);
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 28.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CustomCachedNetworkImage(
                                                      data: chatUser.photoURL,
                                                      radius: 40.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: CustomTextBody2(
                                                          text:
                                                              "${chatUser.displayName}, ${chatUser.age}"),
                                                    )
                                                  ],
                                                ),
                                              );
                                            } else {
                                              print("User list empty");
                                              return const CustomTextHeader1(
                                                  text: "No Data");
                                            }
                                          } else {
                                            print("User list error");
                                            return const CustomTextHeader1(
                                                text: "Error");
                                          }
                                        });
                                  });
                            } else {
                              return const CustomTextHeader1(text: "No Data");
                            }
                          } else {
                            return const CustomTextHeader1(text: "No Data");
                          }
                        }),
                  ),
                ),
                // !SECTION

                // SECTION Conversation list
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 24.0),
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: homeVM
                          .getRecentConversationsList(user.currentUser!.uid),
                      builder: (context, recentConversation) {
                        if (recentConversation.hasError) {
                          return const CustomTextHeader1(text: "Error");
                        }

                        if (recentConversation.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Platform.isIOS
                                ? const CupertinoActivityIndicator(
                                    color: CColors.secondaryColor)
                                : const CircularProgressIndicator(
                                    color: CColors.secondaryColor),
                          );
                        }
                        if (recentConversation.hasData) {
                          if (recentConversation.data!.docs.isNotEmpty) {
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
                                  return FutureBuilder<
                                          DocumentSnapshot<
                                              Map<String, dynamic>>>(
                                      future: homeVM.getConversationDetails(
                                          conversationListDoc["chatUserUid"]),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return const CustomTextHeader1(
                                              text: "Error");
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: Platform.isIOS
                                                ? const CupertinoActivityIndicator(
                                                    color:
                                                        CColors.secondaryColor)
                                                : const CircularProgressIndicator(
                                                    color:
                                                        CColors.secondaryColor),
                                          );
                                        }

                                        if (snapshot.hasData) {
                                          if (snapshot.data!.exists) {
                                            UserModel chatUser =
                                                UserModel.fromMap(snapshot.data!
                                                        .data()
                                                    as Map<String, dynamic>);
                                            return GestureDetector(
                                              onTap: () => pushNewScreen(
                                                  context,
                                                  screen: ConversationScreen(
                                                    chatUser: chatUser,
                                                  ),
                                                  withNavBar: false),
                                              child: Slidable(
                                                endActionPane: ActionPane(
                                                  motion: const ScrollMotion(),
                                                  children: [
                                                    SlidableAction(
                                                      onPressed: (_) => {},
                                                      backgroundColor: CColors
                                                          .buttonLightColor,
                                                      foregroundColor:
                                                          Colors.white,
                                                      icon: CustomIcons.logout,
                                                      label: 'Leave',
                                                    ),
                                                  ],
                                                ),
                                                child: IntrinsicHeight(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          CustomCachedNetworkImage(
                                                            data: chatUser
                                                                .photoURL,
                                                            radius: 45.0,
                                                          ),
                                                          const SizedBox(
                                                            width: 16.0,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              CustomTextBody2(
                                                                  text:
                                                                      "${chatUser.displayName}, ${chatUser.age}"),
                                                              const SizedBox(
                                                                height: 8.0,
                                                              ),
                                                              StreamBuilder<
                                                                      QuerySnapshot<
                                                                          Map<String,
                                                                              dynamic>>>(
                                                                  stream: homeVM
                                                                      .getRecentMessage(
                                                                          conversationListDoc[
                                                                              "id"]),
                                                                  builder: (context,
                                                                      message) {
                                                                    if (message
                                                                            .hasData &&
                                                                        message
                                                                            .data!
                                                                            .docs
                                                                            .isNotEmpty) {
                                                                      return SizedBox(
                                                                        width:
                                                                            width,
                                                                        child: CustomTextHeader2(
                                                                            text:
                                                                                message.data!.docs.first["message"]),
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
                                          } else {
                                            return const CustomTextHeader1(
                                                text: "No Data");
                                          }
                                        } else {
                                          return const CustomTextHeader1(
                                              text: "No Data");
                                        }
                                      });
                                });
                          } else {
                            print("Conversation List empty");
                            return const CustomTextHeader1(text: "No Data");
                          }
                        } else {
                          print("Conversation List error");
                          return const CustomTextHeader1(text: "No Error");
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
}
