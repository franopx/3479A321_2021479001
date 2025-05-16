import 'package:flutter/material.dart';


class AppData extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decreaseCounter() {
    _counter--;

    notifyListeners();
  }

  void resetCounter() {
    _counter = 0;
    notifyListeners();
  }

}