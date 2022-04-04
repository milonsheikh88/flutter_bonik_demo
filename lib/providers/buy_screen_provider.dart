import 'package:flutter_bonik_demo/db_helper/database_handler.dart';
import 'package:flutter_bonik_demo/models/post_model.dart';
import 'package:flutter_bonik_demo/models/size_model.dart';
import 'package:flutter/cupertino.dart';

final _handler = DatabaseHelper();

class BuyScreeProvider with ChangeNotifier {
  List<String> _itemsCat = ['Cat 1', 'Cat 2', 'Cat 3'];
  String _selectedCat;
  List<String> get getItemCat => _itemsCat;
  String get getSelectedCat => _selectedCat;
  void setSelectedCat(String s) {
    _selectedCat = s;
    notifyListeners();
  }

  List<String> _itemsGen = ['Gen 1', 'Gen 2', 'Gen 3'];
  String _selectedGen;
  List<String> get getItemGen=> _itemsGen;
  String get getSelectedGen=> _selectedGen;
  void setSelectedGen(String s) {
    _selectedGen = s;
    notifyListeners();
  }

  double _startColorValue = 0, _endColorValue = 0;
  double get getStartColorValue => _startColorValue;
  double get getEndColorValue => _endColorValue;
  set setStartColorValue(double v) {
    _startColorValue = v;
    notifyListeners();
  }
  set setEndColorValue(double v) {
    _endColorValue = v;
    notifyListeners();
  }

  int _selectedSizeIndex;
  String _selectedSizeValue;
    var _sizeOptions = [
    SizeModel(0,  "Standard size"),
    SizeModel(1,  "Size in month"),
    SizeModel(2, "Size in inches"),
    SizeModel(3, "Size in cm"),
    SizeModel(4, "Size in year"),
    SizeModel(5, "Other size"),
  ];
  List<SizeModel> get getItemSize => _sizeOptions;
  int get getSelectedSizeIndex => _selectedSizeIndex;
  String get getSelectedSizeValue => _selectedSizeValue;
  void setSelectedSizeIndex(int i) {
    _selectedSizeIndex = i;
    notifyListeners();
  }
  void setSelectedSizeValue(String s) {
    _selectedSizeValue = s;
    notifyListeners();
  }

  int _currentPageIndex = 0;
  int get getCurrentPageIndex => _currentPageIndex;
  set setCurrentPageIndex(int s) {
    _currentPageIndex = s;
    notifyListeners();
  }

  String _title;
  String get getTitle => _title;
  void setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  String _days;
  String get getDays => _days;
  void setDays(String value) {
    _days = value;
    notifyListeners();
  }

  String _qty;
  String get getQty => _qty;
  void setQty(String value) {
    _qty = value;
    notifyListeners();
  }

  String _uPrice;
  String get getUPrice => _uPrice;
  void setUPrice(String value) {
    _uPrice = value;
    notifyListeners();
  }

  String _moq;
  String get getMoq => _moq;
  void setMoq(String value) {
    _moq = value;
    notifyListeners();
  }

  String _photo;
  String get getPhoto => _photo;
  void setPhoto(String value) {
    _photo = value;
    notifyListeners();
  }

  bool get isValid {
    // print("_title====>>> ${_title}");
    // print("_days====>>> ${_days}");
    // print("_selectedCat====>>> ${_selectedCat}");
    // print("_selectedGen====>>> ${_selectedGen}");
    // print("_qty====>>> ${_qty}");
    // print("_uPrice====>>> ${_uPrice}");
    // print("_moq====>>> ${_moq}");
    // print("_selectedSizeValue====>>> ${_selectedSizeValue}");
    // print("_photo====>>> ${_photo}");
    if (_title!= null && _days!= null && _selectedCat != null && _selectedGen != null &&
        _qty != null && _uPrice != null && _moq != null && _selectedSizeValue != null && _photo!= null){
      return true;
    } else {
      return false;
    }
  }

  Future<int> submitData() async {
    int result=0;
    result= await _handler.insertPost(
       PostModel(title:_title,days:_days,cat:_selectedCat,gen:_selectedGen,
           qty:int.parse(_qty), price:int.parse(_uPrice), moq:int.parse(_moq),
           scolor: _startColorValue, ecolor:_endColorValue, size:_selectedSizeValue,photo:_photo));
      return result;
  }
}