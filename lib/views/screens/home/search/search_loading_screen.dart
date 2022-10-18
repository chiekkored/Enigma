import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/core/models/match_user_model.dart';
import 'package:enigma/core/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/home/search/search_screen.dart';
import 'package:provider/provider.dart';

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
    UserProvider userProvider = context.read<UserProvider>();
    List<MatchUserModel> myMatches = [];
    // NOTE Get my interests
    FirebaseFirestore.instance
        .collection("users")
        .doc(userProvider.userInfo.uid)
        .collection("interests")
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> myInterests) async {
      // NOTE List all my interest into one array
      List<String> myInterestList = [];
      for (var myInterest in myInterests.docs) {
        myInterestList.addAll(myInterest["interestList"].cast<String>());
      }
      // NOTE Get all users
      await FirebaseFirestore.instance
          .collection("users")
          .get()
          .then((users) async {
        // NOTE Limit matched users
        int limit = 15;
        int count = 0;
        // NOTE Loop all users except myself
        for (var user in users.docs) {
          if (count < limit) {
            if (user.id != userProvider.userInfo.uid) {
              // NOTE Get user's interests with a match of my interests
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(user.id)
                  .collection("interests")
                  .where("interestList", arrayContainsAny: myInterestList)
                  .get()
                  .then((QuerySnapshot<Map<String, dynamic>>
                      matchInterests) async {
                // NOTE Initialize score
                int score = 0;
                // NOTE Count how many interests match to add scores
                for (var matchInterest in matchInterests.docs) {
                  List matchInterestList = matchInterest["interestList"];
                  for (var e in myInterestList) {
                    // NOTE If match interest list contains one of my intersts, add one score
                    matchInterestList.contains(e) ? score++ : e;
                  }
                }
                myMatches.add(
                    MatchUserModel.fromMap({...user.data(), "score": score}));
                // NOTE Add user count if matched for limit
                count++;
              });
            }
          } else {
            // SECTION Navigate New Screen if more than 15 has found
            goToSearchScreen(myMatches);
            // !SECTION
          }
        }
        // SECTION Navigate New Screen after match users below 15 has found
        goToSearchScreen(myMatches);
        // !SECTION
      });
    });
  }

  void goToSearchScreen(List<MatchUserModel> myMatches) {
    if (!mounted) return;
    myMatches.sort((a, b) => b.score.compareTo(a.score));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SearchScreen(myMatches: myMatches)));
  }

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
          Center(
            child: Platform.isIOS
                ? const CupertinoActivityIndicator(
                    color: CColors.secondaryColor)
                : const CircularProgressIndicator(
                    color: CColors.secondaryColor),
          )
        ],
      ),
    ));
  }
}
/// !SECTION