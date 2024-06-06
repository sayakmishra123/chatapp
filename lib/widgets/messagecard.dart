import 'package:chatapp/models/message.dart';
import 'package:flutter/material.dart';

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
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.04,
                vertical: MediaQuery.sizeOf(context).height * 0.01),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
              color: Color.fromARGB(255, 175, 200, 238),
            ),
            child: Text(
              widget.msg.msg,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(widget.msg.sent),
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
          child: Text(widget.msg.sent),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.04,
                vertical: MediaQuery.sizeOf(context).height * 0.01),
            // width: MediaQuery.sizeOf(context).width * 0.3,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
              color: Color.fromARGB(255, 175, 238, 177),
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
}
