import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:enigma/core/models/match_user_model.dart';
import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/home/search/search_screen.dart';

/// SECTION SearchLoadingScreen
/// Widget for finding user matches
///
/// @author Chiekko Red
class SearchLoadingScreen extends StatefulWidget {
  const SearchLoadingScreen({super.key});

  @override
  State<SearchLoadingScreen> createState() => _SearchLoadingScreenState();
}

class _SearchLoadingScreenState extends State<SearchLoadingScreen> {
  @override
  void initState() {
    super.initState();
    searchMatch();
  }

  Future<void> searchMatch() async {
    try {
      UserProvider userProvider = context.read<UserProvider>();
      List<MatchUserModel> myMatches = [];
      // NOTE Get my interests
      FirebaseFirestore.instance
          .collection("users")
          .doc(userProvider.userInfo.uid)
          .collection("interests")
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> myInterests) async {
        debugPrint("✅ [searchMatch][Getting interests] Success");
        // NOTE List all my interest into one array
        List<String> myInterestList = [];
        debugPrint("⏱ Processing: Listing My Interests");
        for (var myInterest in myInterests.docs) {
          myInterestList.addAll(myInterest["interestList"].cast<String>());
        }

        // NOTE List all my existing conversations using chatUserUid
        List<String> existingUsersInConversations = [];
        FirebaseFirestore.instance
            .collection("users")
            .doc(userProvider.userInfo.uid)
            .collection("conversationsList")
            .get()
            .then((QuerySnapshot<Map<String, dynamic>>
                myConversationsList) async {
          debugPrint("✅ [searchMatch][Getting conversationsList] Success");
          debugPrint("⏱ Processing: Listing Users in my Conversations");
          for (var myConversations in myConversationsList.docs) {
            existingUsersInConversations.add(myConversations["uid"].toString());
          }
        });

        // NOTE Get all users
        await FirebaseFirestore.instance
            .collection("users")
            .get()
            .then((users) async {
          debugPrint("✅ [searchMatch][Getting users] Success");
          debugPrint("⏱ Processing: Checking User Matches");
          // NOTE Limit matched users
          int limit = 15;
          int count = 0;
          // NOTE Loop all users except myself
          for (var user in users.docs) {
            if (count < limit) {
              // NOTE Check if user is me && user is existing in the conversations
              if (user.id != userProvider.userInfo.uid &&
                  !existingUsersInConversations.contains(user.id)) {
                // NOTE Partition my interests into 10's due to
                // NOTE Firestore arrayContainsAny only accept below 10
                Iterable<List<String>> myInterestPartition =
                    myInterestList.slices(10);
                // NOTE Initialize mutualInterests
                List mutualInterests = [];
                for (var i = 0; i < myInterestPartition.length; i++) {
                  // NOTE Get user's interests with a match of my interests
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(user.id)
                      .collection("interests")
                      .where("interestList",
                          arrayContainsAny: myInterestPartition.toList()[i])
                      .get()
                      .then((QuerySnapshot<Map<String, dynamic>>
                          matchInterests) async {
                    // NOTE Initialize score
                    // NOTE Count how many interests match to add scores
                    for (var matchInterest in matchInterests.docs) {
                      List matchInterestList = matchInterest["interestList"];
                      for (var e in myInterestList) {
                        // NOTE If match interest list contains one of my intersts, add it to List
                        // matchInterestList.contains(e) ? score++ : e;
                        if (matchInterestList.contains(e)) {
                          mutualInterests.add(e);
                        }
                      }
                    }
                  });
                }
                // NOTE In scoring, remove all duplicates in List and count to score it
                myMatches.add(MatchUserModel.fromMap({
                  ...user.data(),
                  "score": mutualInterests.toSet().toList().length
                }));
                // NOTE Add user count if matched for limit
                count++;
              }
            } else {
              // SECTION Navigate New Screen if more than 15 has found
              debugPrint("✅ [searchMatch] Success");
              goToSearchScreen(myMatches);
              // !SECTION
            }
          }
          // SECTION Navigate New Screen after match users below 15 has found
          debugPrint("✅ [searchMatch] Success");
          goToSearchScreen(myMatches);
          // !SECTION
        });
      });
    } catch (e) {
      debugPrint("❌ [searchMatch] Error");
    }
  }

  /// SECTION goToSearchScreen
  ///
  /// Navigate screen to SearchScreen
  /// LINK ./search_screen.dart
  void goToSearchScreen(List<MatchUserModel> myMatches) {
    if (!mounted) return;
    myMatches.sort((a, b) => b.score.compareTo(a.score));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SearchScreen(myMatches: myMatches)));
  }

  ///!SECTION

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomTextHeader1(text: "Looking for a match"),
          const SizedBox(
            height: 16.0,
          ),
          // SECTION Loading UI
          Center(
            child: Platform.isIOS
                ? const CupertinoActivityIndicator(
                    color: CColors.secondaryColor)
                : const CircularProgressIndicator(
                    color: CColors.secondaryColor),
          )
          // !SECTION
        ],
      ),
    ));
  }
}

/// !SECTION
