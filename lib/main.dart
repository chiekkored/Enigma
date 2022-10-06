import 'package:enigma/core/providers/conversation_provider.dart';
import 'package:enigma/core/providers/user_provider.dart';
import 'package:enigma/views/screens/auth/login_screen.dart';
import 'package:enigma/views/screens/home/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:enigma/utilities/configs/firebase_options.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:giphy_get/l10n.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Firebase Initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final pref = await SharedPreferences.getInstance();
  // pref.clear();
  // await FirebaseAuth.instance.signOut();
  await dotenv.load(fileName: ".env");
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
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();
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
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, user) {
            if (user.hasData) {
              return FutureBuilder<bool>(
                  future: userProvider.getUserPreference(),
                  builder: (context, snapshot) {
                    return const Navigation();
                  });
            } else {
              return const LoginScreen();
            }
          }),
    );
  }
}
