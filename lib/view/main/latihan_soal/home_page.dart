import 'package:final_project_ujian_soal/constants/r.dart';
import 'package:final_project_ujian_soal/view/main/latihan_soal/mapel_page.dart';
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
      backgroundColor: R.colors.grey,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                _buildUserHomeProfile(),
                _buildTopBanner(context),
                _buildHomeListMapel(),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Terbaru",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 170,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Image.asset(R.assets.bannerHome),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _buildHomeListMapel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Pilih Pelajaran",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(MapelPage.route);
                  },
                  child: Text(
                    "lihat Semua",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: R.colors.primary),
                  )),
            ],
          ),
          MapelWidget(),
          MapelWidget(),
          MapelWidget()
        ],
      ),
    );
  }

  Container _buildTopBanner(BuildContext context) {
    return Container(
      height: 147,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20, // vertical: 15
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: R.colors.primary, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
    );
  }

  Padding _buildUserHomeProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hai, Rayhan Andika",
                    style: GoogleFonts.poppins()
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w700)),
                Text("Selamat",
                    style: GoogleFonts.poppins()
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w700)),
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
    );
  }
}

class MapelWidget extends StatelessWidget {
  const MapelWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 21),
      child: Row(
        children: [
          Container(
            height: 53,
            width: 53,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
                color: R.colors.grey, borderRadius: BorderRadius.circular(10)),
            child: Image.asset(R.assets.icAtom),
          ),
          const SizedBox(
            width: 6,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Matematika",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text(
                  "0/50 Paket latihan soal",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: R.colors.greySubtitleHome),
                ),
                const SizedBox(height: 5),
                Stack(
                  children: [
                    Container(
                      height: 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: R.colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                      height: 10,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          color: R.colors.primary,
                          borderRadius: BorderRadius.circular(10)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
