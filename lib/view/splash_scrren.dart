import 'dart:async';

import 'package:final_project_ujian_soal/constants/R.dart';
import 'package:final_project_ujian_soal/view/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "splash_screen";

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (_) => LoginPage()));
      Navigator.of(context).pushNamed(LoginPage.route);
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
