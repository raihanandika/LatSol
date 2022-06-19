import 'package:final_project_ujian_soal/constants/r.dart';
import 'package:final_project_ujian_soal/models/network_response.dart';
import 'package:final_project_ujian_soal/models/paket_soal_list.dart';
import 'package:final_project_ujian_soal/repository/latihan_soal_api.dart';
import 'package:final_project_ujian_soal/view/main/latihan_soal/kerjakan_latihan_soal.dart';
import 'package:flutter/material.dart';

class PaketSoalPage extends StatefulWidget {
  const PaketSoalPage({Key? key, required this.id}) : super(key: key);
  static String route = "paket_soal_page";
  final String id;

  @override
  State<PaketSoalPage> createState() => _PaketSoalPageState();
}

class _PaketSoalPageState extends State<PaketSoalPage> {
  PaketSoalList? paketSoalList;

  getPaketSoal() async {
    final paketSoalResults = await LatihanSoalAPI().getPaketSoal(widget.id);
    if (paketSoalResults.status == Status.success) {
      // print("Mapel result");
      // print(paketSoalResults.data);
      paketSoalList = PaketSoalList.fromJson(paketSoalResults.data!);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaketSoal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.grey,
      appBar: AppBar(
        title: const Text("Paket Soal"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pilih Paket Soal",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            Expanded(
              child: paketSoalList == null
                  ? Center(child: CircularProgressIndicator())
                  : GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: 7 / 6,
                      children:
                          List.generate(paketSoalList!.data!.length, (index) {
                        final currentPaketSoal = paketSoalList!.data![index];
                        return PaketSoalWidget(data: currentPaketSoal);
                      }).toList()
                      // [
                      //   PaketSoalWidget(),
                      //   PaketSoalWidget(),
                      //   PaketSoalWidget()
                      // ],
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaketSoalWidget extends StatelessWidget {
  const PaketSoalWidget({Key? key, required this.data}) : super(key: key);
  final PaketSoalData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return KerjakanLatihanSoalPage(id: data.exerciseId!);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        // margin: const EdgeInsets.all(13.0),
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.withOpacity(0.2)),
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                R.assets.icNote,
                width: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data.exerciseTitle!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("${data.jumlahDone}/${data.jumlahSoal} Paket Soal",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 9,
                    color: R.colors.greySubtitleHome))
          ],
        ),
      ),
    );
  }
}
