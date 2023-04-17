import 'package:flutter/material.dart';

import 'package:tara/utilities/constants/themes_constant.dart';
import 'package:tara/views/commons/texts_common.dart';

/// SECTION TermsAndConditionsScreen
/// TermsAndConditionsScreen Class
///
/// @author Thomas Rey B Barcenas
class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextHeader3(
          text: 'Terms and Conditions',
          color: CColors.trueWhite,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
          color: CColors.trueWhite,
          child: SafeArea(
            child: SingleChildScrollView(
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
                                  text:
                                      "Welcome to Tara!!\n\nThese terms and conditions outline the rules and regulations for the use of Enigma's Website, located at Pocketdevs.ph.\n\nBy accessing this website we assume you accept these terms and conditions. Do not continue to use Tara! if you do not agree to take all of the terms and conditions stated on this page.\n\nThe following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: 'Client', 'You' and 'Your' refers to you, the person log on this website and compliant to the Company's terms and conditions. 'The Company', 'Ourselves', 'We', 'Our' and 'Us', refers to our Company. 'Party', 'Parties', or 'Us', refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client's needs in respect of provision of the Company's stated services, in accordance with and subject to, prevailing law of ph. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.\n\nLICENSE\n\nUnless otherwise stated, Enigma and/or its licensors own the intellectual property rights for all material on Tara!. All intellectual property rights are reserved. You may access this from Tara! for your own personal use subjected to restrictions set in these terms and conditions."),
                            ),

                            /// !SECTION
                          ]))),
            ),
          )),
    );
  }
}
// !SECTION
