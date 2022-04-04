import 'package:flutter/cupertino.dart';

class HomeScreeProvider with ChangeNotifier {
  int _currentNavIndex = 0;
  int get getCurrentNavIndex => _currentNavIndex;

  set setCurrentNavIndex(int s) {
    _currentNavIndex = s;
    notifyListeners();
  }
}