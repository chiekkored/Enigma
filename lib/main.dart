import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:enigma/views/screens/auth/unverified_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:giphy_get/l10n.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:enigma/core/providers/conversation_provider.dart';
import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/utilities/configs/firebase_options.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/screens/auth/login_screen.dart';
import 'package:enigma/views/screens/home/navigation.dart';
import 'package:enigma/views/screens/onboarding/newProfile/new_profile_screen.dart';

// ignore: fixme
// FIXME: Responsive widget for SVG or IMG files
// https://stackoverflow.com/questions/70970308/svg-and-other-picture-format-like-png-jpeg-support-solution

void main() async {
  // NOTE Firebase Initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // NOTE Static Logout
  // final pref = await SharedPreferences.getInstance();
  // pref.clear();
  // await FirebaseAuth.instance.signOut();

  // NOTE Load env file
  await dotenv.load(fileName: ".env");

  // SECTION Provider
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>.value(
        value: UserProvider(),
      ),
      ChangeNotifierProvider<ConversationProvider>.value(
        value: ConversationProvider(),
      ),
    ],
    child: const MyApp(),
  ));
  // !SECTION
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // NOTE localizationsDelegates for GIPHY
      localizationsDelegates: [
        // Default Delegates
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,

        // Add this line
        GiphyGetUILocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      theme: CColors.lightTheme,
      // darkTheme: CColors.darkTheme,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // SECTION Local Preference Check if user preference exist => Navigate to Navigation(Homepage)
    // LINK ./views/screens/home/navigation.dart:10
    UserProvider userProvider = context.read<UserProvider>();
    userProvider.getUserPreference().then((value) async => Timer(
          // NOTE Duration splash screen
          const Duration(seconds: 3),
          () => Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            customPageTransitionFadeIn(value != null
                ? value["status"] == "verified"
                    ? value["fullName"] == ""
                        ? const NewProfileScreen()
                        : const Navigation()
                    : const UnverifiedScreen()
                : const LoginScreen()),
            (_) => false,
          ),
        ));
    // !SECTION
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              CColors.buttonLightColor,
              Color.fromARGB(255, 109, 70, 148)
            ])),
        child: Center(
          child: Image.asset(
            'assets/images/taraLogo.png',
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
      ),
    );
  }
}

/// SECTION customPageTransitionFadeIn
///
/// Custom Page Route Transition
///
/// @params page next screen widget
Route customPageTransitionFadeIn(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, page) {
      var begin = 0.0;
      var end = 1.0;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return FadeTransition(
        opacity: animation.drive(tween),
        child: page,
      );
    },
  );
}
/// !SECTION 
