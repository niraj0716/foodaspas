import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodaspas/signup_screen_active.dart';
import 'package:foodaspas/splash_screen.dart';
import 'package:foodaspas/stream_demo.dart';
import 'package:foodaspas/student.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'User_Profile.dart';
import 'bottom_navgation_bar.dart';
import 'business_listing.dart';
import 'comment.dart';
import 'demo_like.dart';
import 'feed_post.dart';
import 'login_singup_screen.dart';
import 'onbording_screen1.dart';
import 'onbording_screen2.dart';
import 'onbording_screen3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyAllSbx9WBzR8tx-90zwJffCglBlPnAM_c",
              appId: "1:492636987100:android:865870b88edcdd854d5e19",
              messagingSenderId: "492636987100",
              projectId: "foodaspas-9120f"))
      : await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    final box = GetStorage();
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: ThemeData(fontFamily: "BRLNSB"),
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
