import 'package:final_project_ujian_soal/view/main/latihan_soal/home_page.dart';
import 'package:flutter/material.dart';

class MapelPage extends StatelessWidget {
  const MapelPage({Key? key}) : super(key: key);
  static String route = "mapel_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Mata Pelajaran"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: ListView.builder(itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: MapelWidget(),
          );
        }),
      ),
    );
  }
}
