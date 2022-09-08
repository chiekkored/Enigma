import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/commons/inputs_common.dart';
import 'package:enigma/views/commons/texts_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatelessWidget {
  // const LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

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
                      const CustomTextTitle1(text: 'Enigma'),
                      Padding(
                          padding: const EdgeInsets.only(top: 74.0),
                          child: CustomAuthInput(
                              obscureText: false,
                              icon: CustomIcons.user,
                              hintText: 'Student ID',
                              controller: emailTextController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text)),
                      Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: CustomAuthInput(
                              obscureText: true,
                              icon: CustomIcons.password,
                              iconEnd: CustomIcons.eye,
                              hintText: 'Password',
                              controller: passwordTextController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword)),
                      const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: EdgeInsets.only(top: 24.0),
                              child: CustomTextBody2(
                                  text: 'Forgot Password?',
                                  color: CColors.secondaryColor))),
                      Padding(
                        padding: const EdgeInsets.only(top: 36.0),
                        child: CustomPrimaryButton(
                            text: 'Login', doOnPressed: () => {}),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 45.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CustomTextBody2(text: 'Don`t have an account?'),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: CustomTextHeader2(
                                    text: 'Register',
                                    color: CColors.secondaryColor),
                              )
                            ]),
                      ),
                    ]))),
          )),
    );
  }
}
