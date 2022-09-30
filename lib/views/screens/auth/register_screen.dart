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
  bool termsAgree = false;

  /// SECTION registerAttempt function
  void registerAttempt() async {
    debugPrint('Register Attempt');
  }

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
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                      /// SECTION Circle Group
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 100.0),
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
                          padding: const EdgeInsets.only(top: 58.0),
                          child: CustomAuthInput(
                            obscureText: false,
                            icon: CustomIcons.user,
                            hintText: 'School Email',
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
                      /// SECTION Terms and Conditions
                      Padding(
                          padding: const EdgeInsets.only(top: 14.0, left: 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                  activeColor: CColors.buttonLightColor,
                                  value: termsAgree,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      termsAgree = value!;
                                    });
                                  }),
                              const CustomTextHeader2(
                                  text: 'Terms and Conditions'),
                            ],
                          )),

                      /// !SECTION
                      /// SECTION Register Button
                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: CustomPrimaryButton(
                            text: 'Register',
                            doOnPressed: () async {
                              await _authVM
                                  .register(
                                      context,
                                      emailTextController.text,
                                      passwordTextController.text,
                                      confirmPasswordTextController.text)
                                  .then((doc) async {
                                if (doc != null) {
                                  await userProvider.setNewUser(doc.user);
                                }
                              });
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
                                    debugPrint('I got pressed');
                                    Navigator.pop(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const LoginScreen()));
                                  },
                                  child: const CustomTextHeader2(
                                      text: 'Login',
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
