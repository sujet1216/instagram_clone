import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:instagram_clone/logger.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/responsive/mobile_screen.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:provider/provider.dart';

//! git fetch
//! git log HEAD..origin/master - sheamocme rame tu aris ganaxlebuli

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
  // Timer(Duration(seconds: 5), () => print('finished'));
  // Timer.periodic(Duration(seconds: 2), (timer) {
  //   print(timer.tick);
  //   if (timer.tick == 5) {
  //     timer.cancel();
  //   }
  // });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Stream<User?> authStateChanges = FirebaseAuth.instance.authStateChanges();

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: StreamBuilder(
          stream: authStateChanges,
          builder: (context, snapshot) {
            logger.i('snapshot.connectionState: ${snapshot.connectionState}');
            logger.i('snapshot.hasData: ${snapshot.hasData}');
            logger.i('snapshot.hasError: ${snapshot.hasError}');

            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ResponsiveLayout(
                  mobileScreenLayout: MobileScreen(),
                  webScreenLayout: WebScreen(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return Login();
          },
        ),
      ),
    );
  }
}
