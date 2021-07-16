import 'package:flutter/material.dart';
import 'package:mymemo/constants/const.dart';
import 'package:mymemo/view/Home/view-home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'model/person-model.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  int duration =6500;
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
  void initState() {
    super.initState();
    fun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenView(
        home: PersonPage(
          check: b,
        ),
        duration: duration,
        imageSize: 130,
        imageSrc: "assets/images/splash.gif",
        text: "Memo App",
        textType: TextType.ColorizeAnimationText,
        textStyle: customTextStyle,
        colors: [
          kPrimaryColor,
          Colors.white,
          kPrimaryColor.withOpacity(0.5),
        ],
        backgroundColor: Color(0xFFf3f3f3),
      ),
    );
  }
}
