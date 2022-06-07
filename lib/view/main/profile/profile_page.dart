import 'dart:ffi';

import 'package:final_project_ujian_soal/constants/r.dart';
import 'package:final_project_ujian_soal/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Akun Saya"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "Edit",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: R.colors.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            padding:
                const EdgeInsets.only(top: 28, bottom: 60, right: 15, left: 15),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama User",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Nama Sekolah User",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Image.asset(
                  R.assets.imgUser,
                  width: 50,
                  height: 50,
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 13),
            margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 13),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 7, color: Colors.black.withOpacity(0.25))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Identitas Diri"),
                const SizedBox(height: 15),
                Text("Nama Lengkap",
                    style: TextStyle(
                        color: R.colors.greySubtitleHome, fontSize: 12)),
                Text("Nama Lengkap", style: TextStyle(fontSize: 13)),
                const SizedBox(height: 15),
                Text("Nama Lengkap",
                    style: TextStyle(
                        color: R.colors.greySubtitleHome, fontSize: 12)),
                Text("Nama Lengkap", style: TextStyle(fontSize: 13)),
                const SizedBox(height: 15),
                Text("Nama Lengkap",
                    style: TextStyle(
                        color: R.colors.greySubtitleHome, fontSize: 12)),
                Text("Nama Lengkap", style: TextStyle(fontSize: 13)),
                const SizedBox(height: 15),
                Text("Nama Lengkap",
                    style: TextStyle(
                        color: R.colors.greySubtitleHome, fontSize: 12)),
                Text("Nama Lengkap", style: TextStyle(fontSize: 13)),
                const SizedBox(height: 15),
                Text("Nama Lengkap",
                    style: TextStyle(
                        color: R.colors.greySubtitleHome, fontSize: 12)),
                Text("Nama Lengkap", style: TextStyle(fontSize: 13)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await GoogleSignIn().signOut();
              FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 13),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 13),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7, color: Colors.black.withOpacity(0.25))
                  ]),
              child: Row(children: [
                Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                const SizedBox(width: 10),
                Text("Keluar", style: TextStyle(color: Colors.red)),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
