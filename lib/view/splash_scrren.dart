import 'dart:async';

import 'package:final_project_ujian_soal/constants/R.dart';
import 'package:final_project_ujian_soal/view/login_page.dart';
import 'package:final_project_ujian_soal/view/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "splash_screen";

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (_) => LoginPage()));
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print("Login");
        print(user);
        Navigator.of(context).pushReplacementNamed(MainPage.route);
      } else {
        print("Not Login");
        print(user);
        Navigator.of(context).pushReplacementNamed(LoginPage.route);
      }
    });
    return Scaffold(
      backgroundColor: R.colors.primary,
      // appBar: AppBar(),
      body: Center(
        child: Image.asset(R.assets.icSplash),
      ),
    );
  }
}
