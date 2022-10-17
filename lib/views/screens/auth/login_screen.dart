import 'package:enigma/views/screens/onboarding/entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/core/viewmodels/auth_viewmodel.dart';
import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/inputs_common.dart';
import 'package:enigma/views/commons/popups_commons.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:enigma/views/screens/auth/register_screen.dart';
import 'package:enigma/views/screens/auth/unverified_screen.dart';
import 'package:enigma/views/screens/home/navigation.dart';
import 'package:enigma/views/screens/onboarding/newProfile/new_profile_screen.dart';

/// SECTION LoginScreen
/// LoginScreen Class
///
/// @author Thomas Rey B Barcenas
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// ANCHOR Variables
  final AuthViewModel _authVM = AuthViewModel();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  String emailErrorTxt = '';
  String passwordErrorTxt = '';
  bool emailValidator = false;
  bool passwordValidator = false;
  bool isLoading = false;

  /// SECTION loginAttempt function
  loginAttempt() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      // NOTE checks for empty text forms and returns false
      if (emailTextController.text == '' && passwordTextController.text == '') {
        setState(() {
          emailErrorTxt = 'Email is required';
          passwordErrorTxt = 'Password is required';
          emailValidator = true;
          passwordValidator = true;
          isLoading = false;
        });
        debugPrint('👿 Both Email and Password are empty');
        return false;
      }
      if (emailTextController.text == '') {
        setState(() {
          emailErrorTxt = 'Email is required';
          emailValidator = true;
          passwordValidator = false;
          isLoading = false;
        });
        debugPrint('👿 Email is empty');
        return false;
      }
      if (passwordTextController.text == '') {
        setState(() {
          passwordErrorTxt = 'Password is required';
          emailValidator = false;
          passwordValidator = true;
          isLoading = false;
        });
        debugPrint('👿 Password is empty');
        return false;
      }
    }
    // NOTE when text forms are not empty, returns true
    return true;
  }

  /// !SECTION

  @override
  Widget build(BuildContext context) {
    var userProvider = context.read<UserProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CColors.trueWhite,
      body: Container(
          color: CColors.trueWhite,
          child: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
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
                      /// SECTION Enigma Text
                      const Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: CustomTextTitle1(text: 'Enigma'),
                      ),

                      /// !SECTION
                      /// SECTION email TextForm
                      Padding(
                          padding: const EdgeInsets.only(top: 74.0),
                          child: CustomAuthInput(
                            obscureText: false,
                            icon: CustomIcons.user,
                            hintText: 'School Email',
                            controller: emailTextController,
                            textInputAction: TextInputAction.next,
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
                                  text: emailErrorTxt,
                                  color: CColors.dangerColor)),
                        ),
                      ),

                      /// !SECTION
                      /// SECTION Password TextForm
                      Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: CustomAuthPasswordInput(
                            icon: CustomIcons.password,
                            hintText: 'Password',
                            controller: passwordTextController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                          )),

                      /// !SECTION
                      /// SECTION Password Error Text
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 6.0),
                          child: Visibility(
                              visible: passwordValidator,
                              child: CustomTextSubtitle1(
                                  text: passwordErrorTxt,
                                  color: CColors.dangerColor)),
                        ),
                      ),

                      /// !SECTION
                      /// SECTION Forgot Password
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: GestureDetector(
                                onTap: () {
                                  debugPrint('😮 Forgot Password was pressed');
                                },
                                child: const CustomTextBody2(
                                    text: 'Forgot Password?',
                                    color: CColors.secondaryColor),
                              ))),

                      /// !SECTION
                      /// SECTION Login Button
                      Padding(
                        padding: const EdgeInsets.only(top: 36.0),
                        child: CustomPrimaryButtonWithLoading(
                          text: 'Login',
                          loading: isLoading,
                          doOnPressed: () async {
                            if (loginAttempt()) {
                              // NOTE obtains response of signIn auth function
                              dynamic response = await _authVM.signIn(
                                  context,
                                  emailTextController.text,
                                  passwordTextController.text);
                              if (response["status"] == "error") {
                                switch (response["return"]) {
                                  case 1:
                                    setState(() {
                                      emailErrorTxt = 'User Email not found';
                                      emailValidator = true;
                                      passwordValidator = false;
                                      isLoading = false;
                                    });
                                    break;
                                  case 2:
                                    setState(() {
                                      emailErrorTxt = 'Invalid Email';
                                      emailValidator = true;
                                      passwordValidator = false;
                                      isLoading = false;
                                    });
                                    break;
                                  case 3:
                                    setState(() {
                                      passwordErrorTxt = 'Invalid Password';
                                      emailValidator = false;
                                      passwordValidator = true;
                                      isLoading = false;
                                    });
                                    break;
                                  case 4:
                                    setState(() {
                                      emailValidator = false;
                                      passwordValidator = false;
                                      isLoading = false;
                                    });
                                    if (!mounted) return;
                                    showCustomAlertDialog(
                                        context,
                                        "Banned Account",
                                        "This account has been banned due to inappropriate user behavior and is being refrained from logging in nor from creating a new account.",
                                        "Okay",
                                        null);
                                    break;
                                  default:
                                    setState(() {
                                      emailValidator = false;
                                      passwordValidator = false;
                                      isLoading = false;
                                    });
                                }
                                // NOTE verified status users go through this logic
                              } else {
                                switch (response["status"]) {
                                  case 'unverified':
                                    await userProvider
                                        .setUser(response["return"])
                                        .then((value) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const UnverifiedScreen()),
                                          (route) => false);
                                    });
                                    break;
                                  case 'newUser':
                                    await userProvider
                                        .setUser(response["return"])
                                        .then((value) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EntryScreen()),
                                          (route) => false);
                                    });
                                    break;
                                  default:
                                    await userProvider
                                        .setUser(response["return"])
                                        .then((value) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Navigation()),
                                          (route) => false);
                                    });
                                }
                              }
                            }
                          },
                        ),
                      ),

                      /// !SECTION
                      /// SECTION Register Text
                      Padding(
                        padding: const EdgeInsets.only(top: 45.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CustomTextBody2(
                                  text: 'Don\'t have an account?'),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const RegisterScreen()));
                                  },
                                  child: const CustomTextHeader2(
                                      text: 'Register',
                                      color: CColors.secondaryColor),
                                ),
                              )
                            ]),
                      ),

                      /// !SECTION
                    ]))),
          )),
    );
  }
}
// !SECTION
