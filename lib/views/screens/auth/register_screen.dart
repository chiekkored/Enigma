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
import 'package:enigma/views/screens/auth/login_screen.dart';

/// SECTION RegisterScreen
/// RegisterScreen Class
///
/// @author Thomas Rey B Barcenas
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  /// ANCHOR Variables
  final AuthViewModel _authVM = AuthViewModel();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  String emailErrorTxt = '';
  String passwordErrorTxt = '';
  String confirmPasswordErrorTxt = '';
  bool emailValidator = false;
  bool passwordValidator = false;
  bool confirmPasswordValidator = false;
  bool isLoading = false;

  /// SECTION registerAttempt function
  registerAttempt() {
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
          confirmPasswordValidator = false;
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
          confirmPasswordValidator = false;
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
          confirmPasswordValidator = false;
          isLoading = false;
        });
        debugPrint('👿 Password is empty');
        return false;
      }
      if (emailTextController.text != '' && passwordTextController.text != '') {
        if (confirmPasswordTextController.text != passwordTextController.text) {
          setState(() {
            confirmPasswordErrorTxt = 'Passwords do not match';
            emailValidator = false;
            passwordValidator = false;
            confirmPasswordValidator = true;
            isLoading = false;
          });
          debugPrint('👿 Passwords do not match');
          return false;
        }
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
                        padding: const EdgeInsets.only(top: 58.0),
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
                        padding: const EdgeInsets.only(top: 23.0),
                        child: CustomAuthPasswordInput(
                          icon: CustomIcons.password,
                          hintText: 'Password',
                          controller: passwordTextController,
                          textInputAction: TextInputAction.next,
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
                    /// SECTION Confirm Password TextForm
                    Padding(
                        padding: const EdgeInsets.only(top: 23.0),
                        child: CustomAuthPasswordInput(
                          icon: CustomIcons.password,
                          hintText: 'Confirm Password',
                          controller: confirmPasswordTextController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                        )),

                    /// !SECTION
                    /// SECTION Confirm Password Error Text
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 6.0),
                        child: Visibility(
                            visible: confirmPasswordValidator,
                            child: CustomTextSubtitle1(
                                text: confirmPasswordErrorTxt,
                                color: CColors.dangerColor)),
                      ),
                    ),

                    /// !SECTION
                    /// SECTION Register Button
                    Padding(
                      padding: const EdgeInsets.only(top: 21.0),
                      child: CustomPrimaryButtonWithLoading(
                          text: 'Register',
                          loading: isLoading,
                          doOnPressed: () async {
                            if (registerAttempt()) {
                              // NOTE obtains response of register auth function
                              await _authVM
                                  .register(context, emailTextController.text,
                                      passwordTextController.text)
                                  .then((doc) async {
                                if (doc != null) {
                                  if (doc == 'banned') {
                                    showCustomAlertDialog(
                                        context,
                                        "Banned School Email Domain",
                                        "User creation for this School Email Domain has been banned due to inappropriate behavior from a student of the same school.",
                                        "Okay",
                                        null);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    await userProvider
                                        .setNewUser(doc.user)
                                        .then((value) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      showCustomModal(context,
                                          icon: CustomIcons.success,
                                          color: CColors.onlineColor,
                                          widget: const CustomTextHeader3Centered(
                                              text:
                                                  'Account successfully created! Wait for admin confirmation email before you can login to your account.'),
                                          button: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16.0),
                                            child: CustomPrimaryButtonSmall(
                                                text: "Okay",
                                                doOnPressed: () => Navigator
                                                    .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LoginScreen()),
                                                        (route) => false)),
                                          ));
                                    });
                                  }
                                }
                              });
                            }
                          }),
                    ),

                    /// !SECTION
                    /// SECTION Login Text
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomTextBody2(
                                text: 'Already have an account?'),
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
                                    text: 'Login',
                                    color: CColors.secondaryColor),
                              ),
                            )
                          ]),
                    ),

                    /// !SECTION
                  ])),
            ),
          )),
    );
  }
}
// !SECTION
