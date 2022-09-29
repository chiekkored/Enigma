import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/views/commons/images_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
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
    HomeViewModel homeVM = HomeViewModel();
    homeVM.listenNewMatch(context);
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
                    child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        future: homeVM.getRecentUsers(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.done:
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28.0),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      QueryDocumentSnapshot<
                                              Map<String, dynamic>> data =
                                          snapshot.data!.docs[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 28.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CustomCachedNetworkImage(
                                              data: data["dpUrl"],
                                              radius: 40.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: CustomTextBody2(
                                                  text:
                                                      "${data["name"]}, ${data["age"]}"),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              } else {
                                return const Text("No Data");
                              }
                            case ConnectionState.waiting:
                              return Platform.isIOS
                                  ? const CupertinoActivityIndicator()
                                  : const Center(
                                      child: CircularProgressIndicator());
                            default:
                              return const CustomTextHeader1(text: "Error");
                          }
                        }),
                  ),
                ),
                // !SECTION

                // SECTION Conversation list
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 24.0),
                  child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      future: homeVM.getRecentConversations(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            if (snapshot.hasData) {
                              return ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return const Divider();
                                  },
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    QueryDocumentSnapshot<Map<String, dynamic>>
                                        data = snapshot.data!.docs[index];
                                    return GestureDetector(
                                      onTap: () => pushNewScreen(context,
                                          screen: const EntryScreen(),
                                          withNavBar: false),
                                      child: Slidable(
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (_) => {},
                                              backgroundColor:
                                                  CColors.buttonLightColor,
                                              foregroundColor: Colors.white,
                                              icon: CustomIcons.logout,
                                              label: 'Leave',
                                            ),
                                          ],
                                        ),
                                        child: IntrinsicHeight(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  CustomCachedNetworkImage(
                                                    data: data["dpUrl"],
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
                                                        MainAxisSize.min,
                                                    children: [
                                                      CustomTextBody2(
                                                          text:
                                                              "${data["name"]}, ${data["age"]}"),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      SizedBox(
                                                        width: width,
                                                        child: CustomTextHeader2(
                                                            text:
                                                                "${data["display"]}"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 14.0),
                                                  child: CustomTextSubtitle1(
                                                    text: timeago.format(
                                                        data['datetimeCreated']
                                                            .toDate(),
                                                        locale: 'en_short'),
                                                    color: CColors
                                                        .secondaryTextLightColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return const Text("No Data");
                            }
                          case ConnectionState.waiting:
                            return Platform.isIOS
                                ? const CupertinoActivityIndicator()
                                : const Center(
                                    child: CircularProgressIndicator());
                          default:
                            return const CustomTextHeader1(text: "Error");
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
