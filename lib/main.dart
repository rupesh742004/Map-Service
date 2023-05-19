import 'package:copyfile/convert_latlang_to_address.dart';
import 'package:copyfile/google_search_api.dart';
import 'package:copyfile/ui/auth/login_screeen.dart';
import 'package:copyfile/ui/splash_screen.dart';
import 'package:copyfile/user_corent_location.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
        theme:ThemeData(
            primarySwatch: Colors.deepPurple
        ),

      home: SplashScreen(),
    );
  }
}

