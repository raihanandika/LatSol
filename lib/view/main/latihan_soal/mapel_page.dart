import 'package:final_project_ujian_soal/models/mapel_list.dart';
import 'package:final_project_ujian_soal/view/main/latihan_soal/home_page.dart';
import 'package:final_project_ujian_soal/view/main/latihan_soal/paket_soal.dart';
import 'package:flutter/material.dart';

class MapelPage extends StatelessWidget {
  const MapelPage({Key? key, required this.mapelList}) : super(key: key);
  static String route = "mapel_page";
  final MapelList? mapelList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Mata Pelajaran"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: ListView.builder(
            itemCount: mapelList!.data!.length,
            itemBuilder: (context, index) {
              final currentMapel = mapelList!.data![index];
              return GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushNamed(PaketSoalPage.route);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
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
      ),
    );
  }
}
