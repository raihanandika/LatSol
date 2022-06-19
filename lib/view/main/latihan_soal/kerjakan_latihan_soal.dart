import 'package:final_project_ujian_soal/models/kerjakan_soal_list.dart';
import 'package:final_project_ujian_soal/models/network_response.dart';
import 'package:final_project_ujian_soal/repository/latihan_soal_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class KerjakanLatihanSoalPage extends StatefulWidget {
  const KerjakanLatihanSoalPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<KerjakanLatihanSoalPage> createState() =>
      _KerjakanLatihanSoalPageState();
}

class _KerjakanLatihanSoalPageState extends State<KerjakanLatihanSoalPage>
    with SingleTickerProviderStateMixin {
  KerjakanSoalList? soalList;

  getQuestionList() async {
    final resultKerjakanSoal = await LatihanSoalAPI().postQuestion(widget.id);
    if (resultKerjakanSoal.status == Status.success) {
      soalList = KerjakanSoalList.fromJson(resultKerjakanSoal.data!);
      _controller = TabController(length: soalList!.data!.length, vsync: this);
      setState(() {});
    }
  }

  TabController? _controller;

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
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Selanjutnya"))
          ],
        ),
      ),
      body: soalList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                //  TabBar no soal
                Container(
                  child: TabBar(
                    controller: _controller,
                    tabs: List.generate(
                        soalList!.data!.length,
                        (index) => Text('${index + 1}',
                            style: TextStyle(color: Colors.black))).toList(),
                  ),
                ),
                // TabBarView soal dan pilihan
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(8),
                  child: TabBarView(
                      controller: _controller,
                      children: List.generate(
                        soalList!.data!.length,
                        (index) {
                          final currentQuestion = soalList!.data![index];
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Soal no ${index + 1}"),
                                if (currentQuestion.questionTitle != null)
                                  Html(data: currentQuestion.questionTitle!),
                                if (currentQuestion.questionTitleImg != null)
                                  Image.network(
                                      currentQuestion.questionTitleImg!),
                                _buildOption("A", currentQuestion.optionA,
                                    currentQuestion.optionAImg),
                                _buildOption("B", currentQuestion.optionB,
                                    currentQuestion.optionBImg),
                                _buildOption("C", currentQuestion.optionC,
                                    currentQuestion.optionCImg),
                                _buildOption("D", currentQuestion.optionD,
                                    currentQuestion.optionDImg)
                              ],
                            ),
                          );
                        },
                      ).toList()),
                ))
              ],
            ),
    );
  }

  Container _buildOption(String option, String? answer, String? answerImg) {
    return Container(
      child: Row(
        children: [
          Text(option),
          if (answer != null) Expanded(child: Html(data: answer)),
          if (answerImg != null) Expanded(child: Image.network(answerImg))
        ],
      ),
    );
  }
}
