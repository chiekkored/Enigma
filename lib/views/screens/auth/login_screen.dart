import 'package:enigma/core/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/inputs_common.dart';
import 'package:enigma/views/commons/texts_common.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

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

  /// SECTION loginAttempt function
  dynamic loginAttempt() async {
    int result = await _authVM.signIn(
        context, emailTextController.text, passwordTextController.text);
    switch (result) {
      case 0:
        setState(() {
          emailValidator = false;
          passwordValidator = false;
        });
        break;
      case 1:
        setState(() {
          emailErrorTxt = 'Email is required';
          passwordErrorTxt = 'Password is required';
          emailValidator = true;
          passwordValidator = true;
        });
        break;
      case 2:
        setState(() {
          emailErrorTxt = 'Email is required';
          emailValidator = true;
          passwordValidator = false;
        });
        break;
      case 3:
        setState(() {
          passwordErrorTxt = 'Password is required';
          emailValidator = false;
          passwordValidator = true;
        });
        break;
      case 4:
        setState(() {
          emailErrorTxt = 'Email not found';
          emailValidator = true;
          passwordValidator = false;
        });
        break;
      case 5:
        setState(() {
          emailErrorTxt = 'Invalid Email';
          emailValidator = true;
          passwordValidator = false;
        });
        break;
      case 6:
        setState(() {
          passwordErrorTxt = 'Invalid Password';
          emailValidator = false;
          passwordValidator = true;
        });
        break;
    }
  }

  /// !SECTION

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          color: CColors.trueWhite,
          child: SafeArea(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                      /// SECTION Circle Group
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 150.0),
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
                                ]))),
                      ),

                      /// !SECTION
                      /// SECTION Enigma Text
                      const CustomTextTitle1(text: 'Enigma'),

                      /// !SECTION
                      /// SECTION email TextForm
                      Padding(
                          padding: const EdgeInsets.only(top: 74.0),
                          child: CustomAuthInput(
                            obscureText: false,
                            icon: CustomIcons.user,
                            hintText: 'Email',
                            controller: emailTextController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
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
                          child: CustomAuthInput(
                            obscureText: true,
                            icon: CustomIcons.password,
                            iconEnd: CustomIcons.eye,
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
                      const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: EdgeInsets.only(top: 24.0),
                              child: CustomTextBody2(
                                  text: 'Forgot Password?',
                                  color: CColors.secondaryColor))),

                      /// !SECTION
                      /// SECTION Login Button
                      Padding(
                        padding: const EdgeInsets.only(top: 36.0),
                        child: CustomPrimaryButton(
                            text: 'Login', doOnPressed: loginAttempt),
                      ),

                      /// !SECTION
                      /// SECTION Register Text
                      Padding(
                        padding: const EdgeInsets.only(top: 45.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CustomTextBody2(text: 'Don\'t have an account?'),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: CustomTextHeader2(
                                    text: 'Register',
                                    color: CColors.secondaryColor),
                              )
                            ]),
                      ),

                      /// !SECTION
                    ]))),
          )),
    );
  }
}
