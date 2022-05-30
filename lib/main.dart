import 'package:final_project_ujian_soal/view/login_page.dart';
import 'package:final_project_ujian_soal/view/splash_scrren.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const SplashScreen(),
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        LoginPage.route: (context) => LoginPage()
      },
    );
  }
}
