import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  int? userId;
  String? token;

  void setUserId(int id) {
    userId = id;
    notifyListeners();
  }

  void setToken(String value) {
    token = value;
    notifyListeners();
  }
}