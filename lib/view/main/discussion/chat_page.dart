import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  static String route = "chat_page";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController textController = TextEditingController();

  late CollectionReference chat;
  late QuerySnapshot chatData;

  // List<QueryDocumentSnapshot>? listChat;

  // getDatFromFirebase() async {
  //   chatData = await FirebaseFirestore.instance
  //       .collection("room")
  //       .doc("kimia")
  //       .collection("chat")
  //       .get();

  //   listChat = chatData.docs;
  //   setState(() {});
  //   // print(chatData.docs);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDatFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    chat = FirebaseFirestore.instance
        .collection("room")
        .doc("kimia")
        .collection("chat");
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diskusi Soal"),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: chat.orderBy("time").snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                        // print(snapshot.hasData);
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        return ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.docs.reversed.length,
                            itemBuilder: (context, index) {
                              final currentChat =
                                  snapshot.data!.docs.reversed.toList()[index];
                              final currentDate =
                                  (currentChat['time'] as Timestamp?)?.toDate();
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                  crossAxisAlignment:
                                      user!.uid == currentChat['uid']
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                  children: [
                                    Text(currentChat['nama'],
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0XFF5200FF))),
                                    Container(
                                        // width: MediaQuery.of(context).size.width * 0.8,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: user.uid ==
                                                    currentChat['uid']
                                                ? Colors.green.withOpacity(0.5)
                                                : const Color(0XFFFFDCDC),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft:
                                                  user.uid == currentChat['uid']
                                                      ? Radius.circular(10)
                                                      : Radius.circular(0),
                                              bottomRight:
                                                  user.uid == currentChat['uid']
                                                      ? Radius.circular(0)
                                                      : Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            )),
                                        child: Text(currentChat['content'])),
                                    Text(
                                        currentDate == null
                                            ? ""
                                            : DateFormat("dd-MMM-yyy    HH:mm")
                                                .format(currentDate),
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0XFF5200FF)))
                                  ],
                                ),
                              );
                            });
                      }))),
          SafeArea(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    offset: const Offset(0, -1),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.25))
              ]),
              // margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        color: Colors.blue,
                      )),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 40,
                            child: TextField(
                              controller: textController,
                              decoration: InputDecoration(
                                  suffix: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.blue,
                                      )),
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, bottom: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Tulis pesan disini...",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey)),
                            ),
                          )),
                          IconButton(
                              onPressed: () {
                                if (textController.text.isEmpty) {
                                  return;
                                }

                                final chatContent = {
                                  "nama": user!.displayName,
                                  "uid": user.uid,
                                  "content": textController.text,
                                  "email": user.email,
                                  "photo": user.photoURL,
                                  "file_url": "user.photoURL",
                                  "time": FieldValue.serverTimestamp()
                                };

                                chat.add(chatContent).whenComplete(() {
                                  textController.clear();
                                });
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Color.fromARGB(255, 28, 46, 62),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
