import 'dart:convert';
import 'dart:math';

import 'package:chatapp/apis/apis.dart';
import 'package:chatapp/getx/getx.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/modelClass.dart';
import 'package:chatapp/widgets/messagecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatUi extends StatefulWidget {
  final UserDetails userlist;
  late String email;
  ChatUi(this.userlist, this.email, {super.key});

  @override
  State<ChatUi> createState() => _ChatUiState();
}

class _ChatUiState extends State<ChatUi> {
  List<UserMsg> msglist = [];
  late SharedPreferences sp;
  TextEditingController msgController = TextEditingController();

  @override
  void initState() {
    getemail().whenComplete(() => null);
    // TODO: implement initState
    super.initState();
  }

  String email = '';
  Getx getx = Get.put(Getx());
  Future getemail() async {
    sp = await SharedPreferences.getInstance();
    email = sp.getString('email') ?? '';
    print(email + 'dddd');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          widget.userlist.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 226, 235, 243),
        child: StreamBuilder(
            stream: Apis.getAllMsg(widget.userlist, widget.email),
            builder: (context, snapshot) {
              print(snapshot.data);
              final data = snapshot.data?.docs;
              if (snapshot.hasData) {
                msglist =
                    data!.map((e) => UserMsg.fromJson(e.data())).toList() ?? [];
                return ListView.builder(
                    itemCount: msglist.length,
                    itemBuilder: (context, index) {
                      return Messagecard(msglist[index], email);
                      // print(jsonEncode(snapshot.data!.docs[index].data()));
                      // return Card(
                      //   child: ListTile(
                      //     onTap: () {
                      //       // Get.to(() => ChatUi(userlist[index]));
                      //     },
                      //     title: Text(snapshot.data?.docs[index]['msg']),
                      //     subtitle: Text(snapshot.data?.docs[index]['read']),
                      //     trailing: const Icon(
                      //       Icons.circle,
                      //       color: Colors.blue,
                      //     ),
                      //   ),
                      // );
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              color: Colors.transparent),
          height: 60,
          width: MediaQuery.sizeOf(context).width - 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width - 80,
                  child: Card(
                      child: TextFormField(
                    controller: msgController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        hintText: 'Type something...',
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                  ))),
              ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: IconButton(
                      onPressed: () async {
                        if (msgController.text.isNotEmpty) {
                          await Apis.sendMsg(
                              widget.userlist, msgController.text);
                          msgController.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        size: 40,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
