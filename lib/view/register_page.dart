import 'package:final_project_ujian_soal/constants/r.dart';
import 'package:final_project_ujian_soal/helpers/preference_helper.dart';
import 'package:final_project_ujian_soal/helpers/user_email.dart';
import 'package:final_project_ujian_soal/models/network_response.dart';
import 'package:final_project_ujian_soal/models/user_by_email.dart';
import 'package:final_project_ujian_soal/repository/auth_api.dart';
import 'package:final_project_ujian_soal/view/login_page.dart';
import 'package:final_project_ujian_soal/view/main_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static String route = "register_page";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Gender { lakiLaki, perempuan }

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  List<String> classS = ["X", "XI", "XII"];
  String selectedClass = "X";

  String gender = "Laki-laki";

  onTapGender(Gender genderInput) {
    if (genderInput == Gender.lakiLaki) {
      gender = "Laki-laki";
    } else {
      gender = "Perempuan";
    }
    setState(() {});
  }

  initDatUser() {
    emailController.text = UserEmail.getUserEmail()!;
    fullNameController.text = UserEmail.getUserDisplayName()!;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDatUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F3F5),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: AppBar(
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0))),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text("Yuk isi data dirimu",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ButtonLogin(
          onTap: () async {
            final json = {
              "email": emailController.text,
              "nama_lengkap": fullNameController.text,
              "nama_sekolah": schoolNameController.text,
              "kelas": selectedClass,
              "gender": gender,
              "foto": UserEmail.getUserPhotoUrl()
            };
            print(json);
            final result = await AuthAPI().postRegister(json);
            if (result.status == Status.success) {
              final registerResult = UserByEmail.fromJson(result.data!);
              if (registerResult.status == 1) {
                await PreferenceHelper().setUserData(registerResult.data!);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    MainPage.route, (context) => false);
              } else {
                SnackBar(content: Text(registerResult.message!));
              }
            } else {
              SnackBar(
                  content: Text("Terjadi kesalahan, silahkan ulangi kembali"));
            }
          },
          backgroundColor: Colors.blue,
          borderColor: Colors.blue,
          child: Text(R.strings.daftar,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ),
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RegisterTextField(
                controller: emailController,
                title: "Email Anda",
                hintText: "Email",
                enable: false,
              ),
              const SizedBox(height: 15),
              RegisterTextField(
                controller: fullNameController,
                title: "Nama Lengkap Anda",
                hintText: "Nama Lengkap",
              ),
              const SizedBox(height: 15),
              const Text(
                "Jenis Kelamin",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: gender == "Laki-laki"
                                  ? R.colors.primary
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                      width: 1, color: R.colors.greyBorder))),
                          onPressed: () {
                            onTapGender(Gender.lakiLaki);
                          },
                          child: Text(
                            "Laki-Laki",
                            style: TextStyle(
                                fontSize: 14,
                                color: gender == "Laki-laki"
                                    ? Color(0xFF282828)
                                    : R.colors.primary),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: gender == "Perempuan"
                                  ? R.colors.primary
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                      width: 1, color: R.colors.greyBorder))),
                          onPressed: () {
                            onTapGender(Gender.perempuan);
                          },
                          child: Text(
                            "Perempuan",
                            style: TextStyle(
                                fontSize: 14,
                                color: gender == "Perempuan"
                                    ? Color(0xFF282828)
                                    : R.colors.primary),
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                "Kelas",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(color: R.colors.greyBorder)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      value: selectedClass,
                      items: classS
                          .map((e) => DropdownMenuItem<String>(
                              child: Text(e), value: e))
                          .toList(),
                      onChanged: (String? val) {
                        selectedClass = val!;
                        setState(() {});
                      }),
                ),
              ),
              const SizedBox(height: 15),
              RegisterTextField(
                controller: schoolNameController,
                title: "Nama Sekolah",
                hintText: "Nama Sekolah",
              ),
              // const Spacer(),
              // ButtonLogin(
              //   onTap: () {
              //     Navigator.of(context).pushNamed(MainPage.route);
              //   },
              //   backgroundColor: Colors.blue,
              //   borderColor: Colors.blue,
              //   child: Text(R.strings.daftar,
              //       style: const TextStyle(
              //           fontSize: 17,
              //           fontWeight: FontWeight.w700,
              //           color: Colors.white)),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterTextField extends StatelessWidget {
  RegisterTextField(
      {Key? key,
      required this.title,
      required this.hintText,
      required this.controller,
      this.enable = true})
      : super(key: key);
  final String title;
  final String hintText;
  final bool enable;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: R.colors.greyBorder)),
          child: TextField(
            enabled: enable,
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(color: R.colors.greyHintText)),
          ),
        ),
      ],
    );
  }
}
