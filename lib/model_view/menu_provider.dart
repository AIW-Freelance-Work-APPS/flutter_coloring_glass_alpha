import 'package:flutter/material.dart';


class MenuProvider extends ChangeNotifier {
  int selectedIndex = 0;
  get index => selectedIndex;
  
  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}