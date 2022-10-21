import 'package:flutter/material.dart';

import 'package:enigma/core/viewmodels/auth_viewmodel.dart';
import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/inputs_common.dart';
import 'package:enigma/views/commons/popups_commons.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/auth/login_screen.dart';

/// SECTION ForgotPasswordScreen
/// ForgotPasswordScreen Class
///
/// @author Thomas Rey B Barcenas
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // ANCHOR Variables
  final AuthViewModel _authVM = AuthViewModel();
  TextEditingController emailTextController = TextEditingController();
  String emailErrorTxt = '';
  bool emailValidator = false;
  bool isLoading = false;

  // SECTION sendVerificationAttempt
  sendVerificationAttempt() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      // NOTE checks for empty text forms and returns false
      if (emailTextController.text == '') {
        setState(() {
          emailErrorTxt = 'Email is required';
          emailValidator = true;
          isLoading = false;
        });
        debugPrint('👿 Email is empty');
        return false;
      }
    }
    // NOTE when text forms are not empty, returns true
    return true;
  }

  // !SECTION

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CColors.trueWhite,
      body: Container(
        color: CColors.trueWhite,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  /// SECTION Circle Group
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                                width: 25.0,
                                height: 25.0,
                                decoration: const BoxDecoration(
                                    color: CColors.buttonLightColor,
                                    shape: BoxShape.circle)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
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
                                  color: CColors.primaryTextLightColor,
                                  shape: BoxShape.circle)),
                        ])),
                  ),

                  /// !SECTION
                  /// SECTION Tara Logo
                  Image.asset('assets/images/taraLogo.png',
                      width: 150.0, height: 150.0),

                  /// !SECTION
                  /// SECTION Forgot Password Message
                  const Padding(
                    padding: EdgeInsets.only(top: 32.0),
                    child: CustomTextBody1Centered(
                        text:
                            'Enter your email address here so we can send you a link to reset your password.'),
                  ),

                  /// !SECTION
                  /// SECTION email TextForm
                  Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: CustomAuthInput(
                        obscureText: false,
                        icon: CustomIcons.user,
                        hintText: 'School Email',
                        controller: emailTextController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                      )),

                  /// !SECTION
                  /// SECTION email Error Text
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 6.0),
                      child: Visibility(
                          visible: emailValidator,
                          child: CustomTextSubtitle1(
                              text: emailErrorTxt, color: CColors.dangerColor)),
                    ),
                  ),

                  /// !SECTION
                  /// SECTION Reset Password Button
                  Padding(
                    padding: const EdgeInsets.only(top: 36.0),
                    child: CustomPrimaryButtonWithLoading(
                      text: 'Reset Password',
                      loading: isLoading,
                      doOnPressed: () async {
                        if (sendVerificationAttempt()) {
                          _authVM
                              .forgotPassword(context, emailTextController.text)
                              .then((value) {
                            if (value != null) {
                              switch (value) {
                                case 0:
                                  showCustomAlertDialog(
                                      context,
                                      "Error",
                                      "There was an error when sending a reset password link to the email provided. Please try again.",
                                      "Okay",
                                      null);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  break;
                                case 1:
                                  showCustomAlertDialog(
                                      context,
                                      "User Not Found",
                                      "No account was found with the email provided.",
                                      "Okay",
                                      null);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  break;
                                case 2:
                                  showCustomAlertDialog(
                                      context,
                                      "Connection Error",
                                      "Please check connection and try again",
                                      "Okay",
                                      null);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  break;
                                default:
                                  showCustomModal(context,
                                      icon: CustomIcons.success,
                                      color: CColors.onlineColor,
                                      widget: const CustomTextHeader3Centered(
                                          text:
                                              'The link to reset your password has now been sent to your email address. Check your spam messages as it may be sent there.'),
                                      button: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: CustomPrimaryButtonSmall(
                                            text: "Okay",
                                            doOnPressed: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginScreen()),
                                                  (route) => false);
                                            }),
                                      ));
                              }
                            }
                          });
                        }
                      },
                    ),
                  ),

                  // !SECTION
                  /// SECTION Login Text
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomTextBody2(
                              text: 'Remembered your password?'),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const LoginScreen()));
                              },
                              child: const CustomTextHeader2(
                                  text: 'Login', color: CColors.secondaryColor),
                            ),
                          )
                        ]),
                  ),

                  /// !SECTION
                ],
              )),
        )),
      ),
    );
  }
}

// !SECTION
