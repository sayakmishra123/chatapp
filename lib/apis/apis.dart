import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/modelClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Apis {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAlluser(String email) {
    print(email);

    return Apis.firestore
        .collection("userDetails")
        .where('email', isNotEqualTo: email)
        .snapshots();
  }

  static String getConversationID(String id, String email) =>
      email.hashCode <= id.hashCode ? '${email}_$id' : '${id}_$email';
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMsg(
      UserDetails user, email) {
    print(email);
    return firestore
        .collection("chats/${getConversationID(user.email, email)}/message/")
        .snapshots();
  }

  static sendMsg(UserDetails user, String msg) async {
    String email;
    late SharedPreferences sp;
    sp = await SharedPreferences.getInstance();
    email = sp.getString('email') ?? '';
    final time = DateTime.now().toString();

    final UserMsg message = UserMsg(
        msg: msg,
        read: '',
        told: user.email,
        type: Type.text,
        fromId: email,
        sent: time);
    final ref = firestore
        .collection("chats/${getConversationID(user.email, email)}/message/");
    await ref.doc(time).set(message.toJson());
    // return ;
  }
}
