import 'package:final_project_ujian_soal/constants/r.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hai, Rayhan Andika",
                            style: GoogleFonts.poppins().copyWith(
                                fontSize: 12, fontWeight: FontWeight.w700)),
                        Text("Selamat",
                            style: GoogleFonts.poppins().copyWith(
                                fontSize: 12, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Image.asset(
                    R.assets.imgUser,
                    width: 35,
                    height: 35,
                  )
                ],
              ),
            ),
            Container(
              height: 147,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20, // vertical: 15
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  color: R.colors.primary,
                  borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Text("Mau kerjain latihan soal apa hari ini?",
                          style: GoogleFonts.poppins().copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset(R.assets.imgHome,
                        width: MediaQuery.of(context).size.width * 0.40),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Pilih Pelajaran"),
                      TextButton(onPressed: () {}, child: Text("lihat Semua")),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 21),
                    child: Row(
                      children: [
                        Container(
                          height: 53,
                          width: 53,
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              // color: R.colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(R.assets.icAtom),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
