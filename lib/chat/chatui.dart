// ignore_for_file: must_be_immutable, avoid_print



import 'package:chatapp/apis/apis.dart';
import 'package:chatapp/getx/getx.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/modelClass.dart';
import 'package:chatapp/widgets/messagecard.dart';
import 'package:flutter/material.dart';

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

 final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
   final ScrollController _scrollController3 = ScrollController();
  List<UserMsg> msglist = [];
  late SharedPreferences sp;
  TextEditingController msgController = TextEditingController();

  @override
  void initState() {
    getemail().whenComplete(() => null);
   

    super.initState();
  }

  String email = '';
  Getx getx = Get.put(Getx());
  Future getemail() async {
    sp = await SharedPreferences.getInstance();
    email = sp.getString('email') ?? '';
    // ignore: prefer_interpolation_to_compose_strings
    print(email + 'dddd');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
      
        
        backgroundColor:const Color.fromARGB(255, 208, 225, 238),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 208, 225, 238),
          bottom: PreferredSize(
            preferredSize:const Size.fromHeight(70),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child:Column(children: [
                
               
                Container(
                  
                margin:  const EdgeInsets.symmetric(horizontal: 20),
                decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                color:  Color.fromRGBO(144, 164, 174, 1),),
                height: 40,
                child: const TabBar(
                  unselectedLabelColor: Color.fromARGB(255, 0, 0, 0),
                  labelStyle: TextStyle(color: Colors.white),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            
                              // gradient: LinearGradient(
                              //     colors: [ Color.fromARGB(255, 85, 95, 133)]),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Color.fromARGB(255, 44, 53, 85)),
                      
                  tabs: [
                    Tab(
                      text: "Topic 1",
                    ),
                    Tab(
                      text: "topic 2",
                    ),
                    Tab(text: "Topic 2",)
                  ],
                ),
              ),
               const SizedBox(height: 20,)],)
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon:const Icon(Icons.arrow_back_ios_rounded)),
         
        ),
        body: TabBarView(
          children: [
            Container(
              margin:const EdgeInsets.symmetric(horizontal: 20),
             
              child: StreamBuilder(
                  stream: Apis.getAllMsg(widget.userlist, widget.email),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    final data = snapshot.data?.docs;
                    if (snapshot.hasData) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
                      msglist =
                          data!.map((e) => UserMsg.fromJson(e.data())).toList() ??
                              [];
                      return ListView.builder(
                        controller: _scrollController,
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
                    return const  Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
            Container(
              margin:const  EdgeInsets.symmetric(horizontal: 20),
             
              child: StreamBuilder(
                  stream: Apis.getAllMsg(widget.userlist, widget.email),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    final data = snapshot.data?.docs;
                    if (snapshot.hasData) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom2();
        });
                      msglist =
                          data!.map((e) => UserMsg.fromJson(e.data())).toList() ??
                              [];
                      return ListView.builder(
                        controller: _scrollController2,
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
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
              Container(
              margin:const  EdgeInsets.symmetric(horizontal: 20),
             
              child: StreamBuilder(
                  stream: Apis.getAllMsg(widget.userlist, widget.email),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    final data = snapshot.data?.docs;
                    if (snapshot.hasData) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom3();
        });
                      msglist =
                          data!.map((e) => UserMsg.fromJson(e.data())).toList() ??
                              [];
                      return ListView.builder(
                        controller: _scrollController3,
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
                    return const  Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
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
                          onFieldSubmitted: (value)async {
                             if (msgController.text.isNotEmpty) {
                            await Apis.sendMsg(
                                widget.userlist, msgController.text);
                            msgController.clear();
                          }
                          },
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
      ),
    );
  }

  void _scrollToBottom() {
  _scrollController.animateTo(
    _scrollController.position.maxScrollExtent,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOut,
  );
}
 void _scrollToBottom2() {
  _scrollController2.animateTo(
    _scrollController2.position.maxScrollExtent,
    duration:const  Duration(milliseconds: 300),
    curve: Curves.easeOut,
  );
}
 void _scrollToBottom3() {
  _scrollController3.animateTo(
    _scrollController3.position.maxScrollExtent,
    duration:  const Duration(milliseconds: 300),
    curve: Curves.easeOut,
  );
}
}
