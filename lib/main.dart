import 'package:enigma/core/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:enigma/utilities/configs/firebase_options.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/screens/navigation.dart';
import 'package:provider/provider.dart';

void main() async {
  // Firebase Initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>.value(
        value: UserProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CColors.lightTheme,
      // darkTheme: CColors.darkTheme,
      home: const Navigation(),
    );
  }
}
