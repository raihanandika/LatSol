import 'dart:async';

import 'package:final_project_ujian_soal/constants/R.dart';
import 'package:final_project_ujian_soal/helpers/user_email.dart';
import 'package:final_project_ujian_soal/models/network_response.dart';
import 'package:final_project_ujian_soal/models/user_by_email.dart';
import 'package:final_project_ujian_soal/repository/auth_api.dart';
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
      final user = FirebaseAuth.instance.currentUser;
      // final user = UserEmail.getUserEmail();
      // print(user);
      if (user != null) {
        final dataUser = await AuthAPI().getUserByEmail();
        print(dataUser.data);
        print(dataUser.message);
        print(dataUser.status);
        if (dataUser.status == Status.success) {
          final data = UserByEmail.fromJson(dataUser.data!);
          // print(data.status);
          // print(data.message);
          // print(data.data);
          if (data.status == 1) {
            Navigator.of(context).pushNamed(MainPage.route);
          } else {
            Navigator.of(context).pushNamed(RegisterPage.route);
          }
        }
      } else {
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
