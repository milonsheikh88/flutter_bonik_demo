import 'package:flutter_bonik_demo/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'config/route_config.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: RoutConfig().navigationKey,
        home: SplashPage(),
    );
  }
}