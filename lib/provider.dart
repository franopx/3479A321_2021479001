import 'package:flutter/material.dart';
import 'dart:math';

class AppData extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  String _userName = 'Player';
  String get userName => _userName;

  bool _isResetEnabled = true;
  bool get isResetEnabled => _isResetEnabled;


  void setCounter(int value) {
    _counter = value;
    notifyListeners();
  }

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decreaseCounter() {
    _counter--;
    _counter = max(0, _counter);
    notifyListeners();
  }

  void resetCounter() {
    _counter = 0;
    notifyListeners();
  }

  void toggleReset(bool value) {
    _isResetEnabled = value;
    notifyListeners();
  }

  void changeUserName(String newUser) {
    _userName = newUser;
    notifyListeners();
  }
}