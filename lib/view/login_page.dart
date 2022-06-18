import 'package:final_project_ujian_soal/constants/R.dart';
import 'package:final_project_ujian_soal/helpers/preference_helper.dart';
import 'package:final_project_ujian_soal/helpers/user_email.dart';
import 'package:final_project_ujian_soal/models/network_response.dart';
import 'package:final_project_ujian_soal/models/user_by_email.dart';
import 'package:final_project_ujian_soal/repository/auth_api.dart';
import 'package:final_project_ujian_soal/view/main/latihan_soal/home_page.dart';
import 'package:final_project_ujian_soal/view/main_page.dart';
import 'package:final_project_ujian_soal/view/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String route = "login_screen";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F3F8),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(R.strings.login,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 20),
            Image.asset(R.assets.imgLogin),
            const SizedBox(height: 35),
            Text(R.strings.welcome,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
            Text(R.strings.loginDescription,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: R.colors.greySubtitle)),
            const Spacer(),
            ButtonLogin(
              onTap: () async {
                // Navigator.of(context).pushNamed(RegisterPage.route);
                await signInWithGoogle();
                final user = UserEmail.getUserEmail();
                if (user != null) {
                  // print("Login Login Screen");
                  // print(user);
                  final dataUser = await AuthAPI().getUserByEmail();
                  if (dataUser.status == Status.success) {
                    // print("Login Login Screen");
                    // print(dataUser);
                    final data = UserByEmail.fromJson(dataUser.data!);
                    if (data.status == 1) {
                      // print("Login Login Screen");
                      // print(data);
                      // print(data.status);
                      await PreferenceHelper().setUserData(data.data!);
                      Navigator.of(context).pushNamed(MainPage.route);
                    } else {
                      Navigator.of(context).pushNamed(RegisterPage.route);
                    }
                  }
                  Navigator.of(context).pushNamed(MainPage.route);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Gagal Masuk"),
                      duration: Duration(seconds: 2)));
                }
              },
              backgroundColor: Colors.white,
              borderColor: R.colors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(R.assets.icGoogle),
                  const SizedBox(width: 15),
                  Text(R.strings.loginWithGoogle,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: R.colors.blackLogin)),
                ],
              ),
            ),
            ButtonLogin(
              onTap: () {
                Navigator.of(context).pushNamed(RegisterPage.route);
              },
              backgroundColor: Colors.black,
              borderColor: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(R.assets.icApple),
                  const SizedBox(width: 15),
                  Text(R.strings.loginWithApple,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ButtonLogin extends StatelessWidget {
  const ButtonLogin(
      {Key? key,
      required this.backgroundColor,
      required this.child,
      required this.borderColor,
      required this.onTap})
      : super(key: key);

  final Color backgroundColor;
  final Widget child;
  final Color borderColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: backgroundColor,
              elevation: 0,
              fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(25))),
          onPressed: onTap,
          child: child),
    );
  }
}
