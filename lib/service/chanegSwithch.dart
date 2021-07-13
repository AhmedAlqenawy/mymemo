  import 'package:flutter/cupertino.dart';

class SwichProvider extends ChangeNotifier{
  bool _val;
  bool get val => _val;

  init(){
    _val=false;
  }


  changeSwich(bool value){
    _val = value;
    print(_val.toString()+"from vhange");
    notifyListeners();
  }
}

  class NumberProvider extends ChangeNotifier {
    int _number1 =5;
    int _number2 = 1;
    int get number1 => _number1;
    int get number2 => _number2;

    void add() {
      _number1++;
      _number2++;
      notifyListeners();
    }

    void addTo1() {
      _number1++;
      print("pressef");
      print(_number1);
      notifyListeners();
    }

    void addTo2() {
      _number2++;
      notifyListeners();
    }
  }
