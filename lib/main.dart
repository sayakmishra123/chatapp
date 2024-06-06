import 'package:chatapp/chat/chatui.dart';
import 'package:chatapp/getx/getx.dart';
import 'package:chatapp/showdata.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

// ...
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Getx getx = Get.put(Getx());
  @override
  void initState() {
    getadta().whenComplete(() => null);
    super.initState();
  }

  late SharedPreferences sp;
  var data = '';
  Future getadta() async {
    sp = await SharedPreferences.getInstance();

    getx.email.value = sp.getString('email') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ShowData(getx.email.value),
    );
  }
}
