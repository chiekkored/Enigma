import 'package:flutter/material.dart';

import 'package:tara/utilities/constants/themes_constant.dart';
import 'package:tara/views/commons/texts_common.dart';

/// SECTION PrivacyPolicyScreen
/// PrivacyPolicyScreen Class
///
/// @author Thomas Rey B Barcenas
class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextHeader3(
          text: 'Privacy Policy',
          color: CColors.trueWhite,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
          color: CColors.trueWhite,
          child: SafeArea(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// SECTION Tara Logo
                          Image.asset('assets/images/taraLogo.png',
                              width: 150.0, height: 150.0),

                          /// !SECTION
                          /// SECTION Unverified Text
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 24.0),
                            child: CustomTextBody2Centered(
                                text: "Insert Privacy Policy text here"),
                          ),

                          /// !SECTION
                        ]))),
          )),
    );
  }
}
// !SECTION
