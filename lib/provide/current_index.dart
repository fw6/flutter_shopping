import 'package:flutter/material.dart';

class CurrentIndexProvider with ChangeNotifier {
  int currentIndex = 0;
  changeIndex(int index) {
    currentIndex = index;

    notifyListeners();
  }
}
