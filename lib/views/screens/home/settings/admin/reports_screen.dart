import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:tara/core/models/user_model.dart';
import 'package:tara/core/viewmodels/admin_viewmodel.dart';
import 'package:tara/utilities/configs/custom_icons.dart';
import 'package:tara/utilities/constants/themes_constant.dart';
import 'package:tara/views/commons/buttons_common.dart';
import 'package:tara/views/commons/texts_common.dart';
import 'package:tara/views/screens/home/conversation/conversation_screen.dart';

class AdminReportsScreen extends StatelessWidget {
  const AdminReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AdminViewModel adminVM = AdminViewModel();
    List<Map<String, dynamic>> userSelectedList = [];
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextHeader3(
          text: 'Administrator',
          color: CColors.trueWhite,
        ),
        actions: [
          CustomTextButton(
              child: const Text(
                "Ban",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                if (userSelectedList
                    .any((element) => element["value"] == true)) {
                  adminVM.banUsers(userSelectedList);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please select an item."),
                  ));
                }
              })
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("reports").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const CustomTextHeader1(text: "Error");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator(
                        color: CColors.secondaryColor)
                    : const CircularProgressIndicator(
                        color: CColors.secondaryColor),
              );
            }
            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  return FutureBuilder<List<Map<String, dynamic>>>(
                      future: adminVM.getUsers([
                        snapshot.data!.docs[index]["chatUserUid"],
                        snapshot.data!.docs[index]["userUid"]
                      ]),
                      builder: (context, futureSnapshot) {
                        if (futureSnapshot.hasError) {
                          return const CustomTextHeader1(text: "Error");
                        }
                        if (futureSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: SizedBox(
                              width: 15.0,
                              height: 15.0,
                              child: Platform.isIOS
                                  ? const CupertinoActivityIndicator(
                                      color: CColors.secondaryColor)
                                  : const CircularProgressIndicator(
                                      color: CColors.secondaryColor),
                            ),
                          );
                        }
                        userSelectedList.add({
                          "chatUserUid": snapshot.data!.docs[index]
                              ["chatUserUid"],
                          "value": false,
                          "reportID": snapshot.data!.docs[index].id
                        });
                        return ListTile(
                          onTap: () => snapshot.data!.docs[index]["status"] ==
                                  "pending"
                              ? pushNewScreen(context,
                                  screen: ConversationScreen(
                                      chatUser: UserModel.fromMap(
                                          futureSnapshot.data![0]),
                                      conversationID: snapshot.data!.docs[index]
                                          ["conversationID"],
                                      conversationListID: snapshot.data!
                                          .docs[index]["conversationListID"]),
                                  withNavBar: false)
                              : null,
                          leading:
                              StatefulBuilder(builder: (context, setState) {
                            if (snapshot.data!.docs[index]["status"] ==
                                "pending") {
                              return Checkbox(
                                  value: userSelectedList[index]["value"],
                                  onChanged: (value) {
                                    setState(() {
                                      userSelectedList[index]["value"] = value!;
                                    });
                                  });
                            } else {
                              return const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.0),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 36.0,
                                ),
                              );
                            }
                          }),
                          title: CustomTextHeader2(
                            text: snapshot.data!.docs[index]["reason"],
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextSubtitle1(
                                text:
                                    "User reported: ${futureSnapshot.data![0]["fullName"]}",
                              ),
                              CustomTextSubtitle1(
                                text:
                                    "Reported by: ${futureSnapshot.data![1]["fullName"]}",
                              ),
                            ],
                          ),
                          trailing:
                              snapshot.data!.docs[index]["status"] == "pending"
                                  ? const Icon(
                                      CustomIcons.right,
                                      color: CColors.secondaryColor,
                                    )
                                  : null,
                        );
                      });
                }));
          }),
    );
  }
}
