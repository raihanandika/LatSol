import 'package:final_project_ujian_soal/constants/r.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static String route = "main_page";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 20,
            color: Colors.black.withOpacity(0.06))
      ]),
      child: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 60,
          child: Row(
            children: [
              Material(
                child: InkWell(
                  child: Column(
                    children: [
                      Image.asset(
                        R.assets.imgHome,
                        height: 20,
                      ),
                      Text("Home")
                    ],
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  child: Column(
                    children: [
                      Image.asset(
                        R.assets.imgHome,
                        height: 20,
                      ),
                      Text("Home")
                    ],
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  child: Column(
                    children: [
                      Image.asset(
                        R.assets.imgHome,
                        height: 20,
                      ),
                      Text("Home")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
