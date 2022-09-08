import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/views/commons/buttons_common.dart';
import 'package:enigma/views/screens/auth/login_screen.dart';
import 'package:enigma/views/screens/onboarding/entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CustomIcons.add),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomPrimaryButton(
                text: "Auth Screen",
                doOnPressed: () => {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => LoginScreen()))
                    }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomPrimaryButton(
                text: "Entry Screen",
                doOnPressed: () => {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const EntryScreen()))
                    }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomPrimaryButton(
                text: "Home Screen",
                doOnPressed: () => {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const EntryScreen()))
                    }),
          ),
        ],
      ),
    );
  }
}
