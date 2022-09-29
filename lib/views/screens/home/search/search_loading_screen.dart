import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/home/search/search_screen.dart';

class SearchLoadingScreen extends StatelessWidget {
  const SearchLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      // SECTION Navigate New Screen
      onTap: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SearchScreen())),
      // !SECTION
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomTextHeader1(text: "Looking for a match"),
            const SizedBox(
              height: 16.0,
            ),
            Platform.isIOS
                ? const CupertinoActivityIndicator()
                : const Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    ));
  }
}
