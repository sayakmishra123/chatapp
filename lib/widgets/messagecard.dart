import 'package:chatapp/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Messagecard extends StatefulWidget {
  late UserMsg msg;
  String email;
  Messagecard(this.msg, this.email, {super.key});

  @override
  State<Messagecard> createState() => _MessagecardState();
}

class _MessagecardState extends State<Messagecard> {
  
 
  @override
  Widget build(BuildContext context) {
    return widget.email == widget.msg.fromId ? _greenmsg() : _blueMsg();
  }

//sender or another msg
  Widget _blueMsg() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: widget.msg.msg.length<5? EdgeInsets.symmetric(vertical: 5, horizontal: 18):EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.04,
                vertical: MediaQuery.sizeOf(context).height * 0.01),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  // bottomLeft: Radius.circular(20),
                  // topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  ),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Text(
              widget.msg.msg,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:Text(formatedTime(widget.msg.sent)),
        )
      ],
    );
  }

//our or user msg
  Widget _greenmsg() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(formatedTime(widget.msg.sent)),
        ),
        Flexible(
          child: Container(
           padding:widget.msg.msg.length<5? EdgeInsets.symmetric(vertical: 5, horizontal: 18):EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.04,
                vertical: MediaQuery.sizeOf(context).height * 0.01),
            // width: MediaQuery.sizeOf(context).width * 0.3,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                 ),
                  
              color: Color.fromRGBO(144, 164, 174, 1),
            ),

            child: Text(
              widget.msg.msg,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }


  String formatedTime(dateTimeString) {
 
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedTime = DateFormat('h.mm a').format(dateTime);
  print(formattedTime);
  return formattedTime;  // Output: 5.00 PM
}
}
