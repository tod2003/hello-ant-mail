import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterwhatsapp/page_home.dart';
import 'package:flutterwhatsapp/pages/login.dart';
import 'package:flutterwhatsapp/pages/setting.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "WhatsApp",
      theme: new ThemeData(
        primaryColor: new Color(0xff075E54),
        accentColor: new Color(0xff25D366),
      ),
      debugShowCheckedModeBanner: false,
      home: new LoginPage(/*cameras:cameras*/),//new WhatsAppHome(cameras:cameras),
      routes: {
        '/loginPage': (ctx) => LoginPage(/*cameras:cameras*/),
        '/homePage': (ctx) => WhatsAppHome(/*cameras:cameras*/),
        '/settingPage': (ctx) => SettingPage(/*cameras:cameras*/),
      },
    );
  }
}
