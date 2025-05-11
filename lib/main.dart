import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen.dart';
import 'package:instagram_clone/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBEnU7tuXdjIcAD1ZXEyoSLq_Xla3y9qDc",
        appId: "1:1020430970332:web:a19abe523ef90edf5af319",
        messagingSenderId: "1020430970332",
        projectId: "stagram-clone",
        storageBucket: "stagram-clone.firebasestorage.app",
        authDomain: "stagram-clone.firebaseapp.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      // home: ResponsiveLayout(mobileScreenLayout: MobileScreen(), webScreenLayout: WebScreen()),
      home: Login(),
    );
  }
}
