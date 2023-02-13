import 'package:flutter/material.dart';
import 'package:test/common/helper.dart';
class SettingProvider extends ChangeNotifier {
  String title='score title';
  int maxPlayerCount=3;
  bool winnerByTwo=true;
  bool winnerServe=true;
   get gettitlet => title;
  void setTitle(String value) {
    title = value;
    notifyListeners();
  }
  get getmaxPlayerCount => maxPlayerCount;
  void setMaxPlayerCount(int count) {
    maxPlayerCount = count;
    notifyListeners();
  }
  get getwinnerByTwo => winnerByTwo;
  void setWinnerByTwo(bool value) {
    winnerByTwo = value;
    notifyListeners();
  }
  get getwinnerServe => winnerServe;
  void setWinnerServe(bool value) {
    winnerServe = value;
    notifyListeners();
  }
}
