import 'package:flutter/material.dart';

class RoutConfig {

  static final RoutConfig _instance = RoutConfig._internal();
  RoutConfig._internal();

  factory RoutConfig() => _instance;

  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  dynamic goBack([dynamic popValue]) {
    return navigationKey.currentState.pop(popValue);
  }

  Future<dynamic> navigateToScreen(Widget page, {arguments}) async => navigationKey.currentState.push(
    MaterialPageRoute(
      builder: (_) => page,
    ),
  );

  Future<dynamic> replaceScreen(Widget page, {arguments}) async => navigationKey.currentState.pushReplacement(
    MaterialPageRoute(
      builder: (_) => page,
    ),
  );

  void popToFirst() => navigationKey.currentState.popUntil((route) => route.isFirst);
}