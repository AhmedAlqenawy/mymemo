import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mymemo/view/Home/home-controller.dart';
import 'package:mymemo/view/Home/view-home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'model/person-model.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  int d = 4000;
  List<Person> list = [];
  SharedPreferences prefs;
  bool b;

  fun() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString("last") == null) {
      prefs.setString("last", DateTime.now().toString());
      print("from 1");
      b = true;
    } else {
      print(DateTime.now()
          .difference(DateTime.parse(prefs.getString("last")))
          .inMinutes);
      if (DateTime.now()
              .difference(DateTime.parse(prefs.getString("last")))
              .inMinutes >= 1) {
        prefs.setString("last", DateTime.now().toString());
        b = true;
        print("from 2");
      } else {
        b = false;
        print("from 3");
      }
    }
  }

  @override
  initState() {
    fun();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash screen Demo',
      home: SplashScreenView(
        home: PersonPage(
          check: b,
        ),
        duration: d,
        imageSize: 130,
        imageSrc: "assets/book.png",
        text: "Memo App",
        textType: TextType.ColorizeAnimationText,
        textStyle: TextStyle(
          fontSize: 40.0,
        ),
        colors: [
          Colors.purple,
          Colors.blue,
          Colors.yellow,
          Colors.red,
        ],
        backgroundColor: Colors.white,
      ),
    );
  }
}
