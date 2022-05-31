import 'package:final_project_ujian_soal/constants/r.dart';
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
  String gender = "Laki-laki";

  onTapGender(Gender genderInput) {
    if (genderInput == Gender.lakiLaki) {
      gender = "Laki-laki";
    } else {
      gender = "Perempuan";
    }
    setState(() {});
  }

  List<String> classS = ["X", "XI", "XII"];
  String selectedClass = "X";
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Yuk isi data dirimu",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18)),
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ButtonLogin(
          onTap: () {
            Navigator.of(context).pushNamed(MainPage.route);
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
                title: "Nama Lengkap",
                hintText: "Nama Lengkap",
              ),
              const SizedBox(height: 15),
              RegisterTextField(
                controller: emailController,
                title: "Email Anda",
                hintText: "Email",
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
                controller: emailController,
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
      required this.controller})
      : super(key: key);
  final String title;
  final String hintText;
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
