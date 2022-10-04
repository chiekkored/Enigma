import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/core/viewmodels/auth_viewmodel.dart';
import 'package:enigma/views/commons/popups_commons.dart';
import 'package:enigma/views/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/inputs_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:provider/provider.dart';

class UnverifiedScreen extends StatefulWidget {
  const UnverifiedScreen({Key? key}) : super(key: key);

  @override
  State<UnverifiedScreen> createState() => _UnverifiedScreenState();
}

class _UnverifiedScreenState extends State<UnverifiedScreen> {
  /// ANCHOR Variables
  final AuthViewModel _authVM = AuthViewModel();
  bool isLoading = false;

  /// SECTION registerAttempt function
  ///
  /// !SECTION

  @override
  Widget build(BuildContext context) {
    var userProvider = context.read<UserProvider>();
    return Scaffold(
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
                          /// SECTION Circle Group
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 100.0),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Container(
                                            width: 25.0,
                                            height: 25.0,
                                            decoration: const BoxDecoration(
                                                color: CColors.buttonLightColor,
                                                shape: BoxShape.circle)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Container(
                                            width: 25.0,
                                            height: 25.0,
                                            decoration: const BoxDecoration(
                                                color: CColors.secondaryColor,
                                                shape: BoxShape.circle)),
                                      ),
                                      Container(
                                          width: 25.0,
                                          height: 25.0,
                                          decoration: const BoxDecoration(
                                              color:
                                                  CColors.primaryTextLightColor,
                                              shape: BoxShape.circle)),
                                    ]))),
                          ),

                          /// !SECTION
                          /// SECTION Enigma Text
                          const CustomTextTitle1(text: 'Enigma'),

                          /// !SECTION
                          /// SECTION Enigma Text
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 24.0),
                            child: CustomTextHeader3Centered(
                                text:
                                    'Your account is currently unverified. Please wait while your account is being verified by our Admins. Thank you!'),
                          ),

                          /// !SECTION
                          /// SECTION Back to Login screen button
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 21.0, horizontal: 24.0),
                            child: CustomPrimaryButtonWithLoading(
                                text: 'Back to Login',
                                loading: isLoading,
                                doOnPressed: () async {
                                  if (!isLoading) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    _authVM.logout();
                                    Navigator.of(context, rootNavigator: true)
                                        .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()),
                                            (route) => false);
                                  }
                                }),
                          ),

                          /// !SECTION
                        ]))),
          )),
    );
  }
}
