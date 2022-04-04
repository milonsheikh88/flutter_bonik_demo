import 'package:flutter_bonik_demo/constants/color_constant.dart';
import 'package:flutter_bonik_demo/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {

  double _height=0;
  double _weight=0;

  void navigationToNextPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  startSplashScreenTimer() async {
    var _duration = new Duration(milliseconds: 3000);
    return Timer(_duration, navigationToNextPage);
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 10), (){
      _height=360;
      _weight=360;
    });
    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_white,
        body: Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 700),
            height: _height,
             width: _weight,
             child: Hero(
               tag: "logo",
               child: Image.asset("assets/img/splash1.jpg"),
             ),
          ),
        )
    );
  }
}