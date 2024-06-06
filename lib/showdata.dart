import 'dart:convert';
import 'dart:math';

import 'package:chatapp/apis/apis.dart';
import 'package:chatapp/chat/chatui.dart';
import 'package:chatapp/getx/getx.dart';
import 'package:chatapp/models/modelClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowData extends StatefulWidget {
  String email;
  ShowData(this.email, {super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  List<UserDetails> userlist = [];
  Getx getx = Get.put(Getx());
  late SharedPreferences sp;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dialog();
    });

    super.initState();
  }

  TextEditingController email = TextEditingController();

  Future dialog() async {
    sp = await SharedPreferences.getInstance();
    getx.email.value = sp.getString('email') ?? '';
    print(getx.email.value);
    if (getx.email.value == '') {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (contex) {
            return AlertDialog(
              title: Text('Enter your Email'),
              content: TextFormField(
                controller: email,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      sp = await SharedPreferences.getInstance();
                      sp.setString('email', email.text);
                      Get.back();
                    },
                    child: Text('Ok'))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Chat User'),
        centerTitle: true,
      ),
      body: Obx(
        () => StreamBuilder(
            stream: Apis.getAlluser(getx.email.value),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data?.docs;
                userlist =
                    data!.map((e) => UserDetails.fromJson(e.data())).toList() ??
                        [];
                // print(userlist[0].email);
                // print(jsonEncode(snapshot.data?.docs[0].data()));

                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Get.to(() =>
                                ChatUi(userlist[index], getx.email.value));
                          },
                          title: Text(snapshot.data?.docs[index]['email']),
                          subtitle: Text(snapshot.data?.docs[index]['name']),
                          trailing: const Icon(
                            Icons.circle,
                            color: Colors.blue,
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
