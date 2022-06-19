import 'package:final_project_ujian_soal/constants/r.dart';
import 'package:final_project_ujian_soal/models/banner_list.dart';
import 'package:final_project_ujian_soal/models/mapel_list.dart';
import 'package:final_project_ujian_soal/models/network_response.dart';
import 'package:final_project_ujian_soal/repository/latihan_soal_api.dart';
import 'package:final_project_ujian_soal/view/main/latihan_soal/mapel_page.dart';
import 'package:final_project_ujian_soal/view/main/latihan_soal/paket_soal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapelList? mapelList;

  getMapel() async {
    final mapelResults = await LatihanSoalAPI().getMapel();
    if (mapelResults.status == Status.success) {
      // print("Mapel result");
      print(mapelResults.data);
      mapelList = MapelList.fromJson(mapelResults.data!);
      setState(() {});
    }
  }

  BannerList? bannerList;

  getBanner() async {
    final bannerResults = await LatihanSoalAPI().getBanner();
    if (bannerResults.status == Status.success) {
      bannerList = BannerList.fromJson(bannerResults.data!);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMapel();
    getBanner();
  }

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
                _buildHomeListMapel(mapelList),
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
                      bannerList == null
                          ? Container(
                              height: 70,
                              width: double.infinity,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : Container(
                              height: 170,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: bannerList!.data!.length,
                                  itemBuilder: (context, index) {
                                    final currentBanner =
                                        bannerList!.data![index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                              currentBanner.eventImage!)),
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

  Container _buildHomeListMapel(MapelList? list) {
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return MapelPage(mapelList: mapelList!);
                    }));
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
          list == null
              ? Container(
                  height: 70,
                  width: double.infinity,
                  child: Center(child: const CircularProgressIndicator()),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.data!.length > 3 ? 3 : list.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final currentMapel = list.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return PaketSoalPage(id: currentMapel.courseId!);
                        }));
                      },
                      child: MapelWidget(
                        title: currentMapel.courseName!,
                        totalDone: currentMapel.jumlahDone!,
                        totalPacket: currentMapel.jumlahMateri!,
                      ),
                    );
                  }),
          // MapelWidget(),
          // MapelWidget(),
          // MapelWidget()
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
    required this.title,
    required this.totalDone,
    required this.totalPacket,
    // required this.jumlahSoal,
    // required this.jumlahDone,
  }) : super(key: key);

  final String title;
  final int? totalDone;
  final int? totalPacket;
  // final int? jumlahSoal;
  // final int? jumlahDone;

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
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text(
                  "$totalDone/$totalPacket Paket latihan soal",
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
                      // width: double.infinity,
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
