import 'package:final_project_ujian_soal/models/kerjakan_soal_list.dart';
import 'package:final_project_ujian_soal/models/network_response.dart';
import 'package:final_project_ujian_soal/repository/latihan_soal_api.dart';
import 'package:flutter/material.dart';

class KerjakanLatihanSoalPage extends StatefulWidget {
  const KerjakanLatihanSoalPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<KerjakanLatihanSoalPage> createState() =>
      _KerjakanLatihanSoalPageState();
}

class _KerjakanLatihanSoalPageState extends State<KerjakanLatihanSoalPage> {
  KerjakanSoalList? soalList;

  getQuestionList() async {
    final resultKerjakanSoal = await LatihanSoalAPI().postQuestion(widget.id);
    if (resultKerjakanSoal.status == Status.success) {
      soalList = KerjakanSoalList.fromJson(resultKerjakanSoal.data!);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latihan Soal"),
      ),
      // tombol selanjutnya atau submit
      bottomNavigationBar: Container(),
      body: soalList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                //  TabBar no soal
                Container(),
                // TabBarView soal dan pilihan
                Expanded(child: Container())
              ],
            ),
    );
  }
}
