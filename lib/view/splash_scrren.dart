import 'dart:async';

import 'package:final_project_ujian_soal/constants/R.dart';
import 'package:final_project_ujian_soal/constants/repository/auth_api.dart';
import 'package:final_project_ujian_soal/models/user_by_email.dart';
import 'package:final_project_ujian_soal/view/login_page.dart';
import 'package:final_project_ujian_soal/view/main_page.dart';
import 'package:final_project_ujian_soal/view/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "splash_screen";

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () async {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (_) => LoginPage()));
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print("Login");
        // print(user);
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // print(user);
          final dataUser = await AuthAPI().getUserByEmail(user.email);
          if (dataUser != null) {
            final data = UserByEmail.fromJson(dataUser);
            if (data.status == 1) {
              Navigator.of(context).pushNamed(MainPage.route);
            } else {
              Navigator.of(context).pushNamed(RegisterPage.route);
            }
          }
        }
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
