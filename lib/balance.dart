import 'package:flutter/foundation.dart';

class Money with ChangeNotifier {
  int _balance = 10000;

  int get balance => _balance;

  set balance(int b) {
    _balance = b;
    notifyListeners();
  }
}
