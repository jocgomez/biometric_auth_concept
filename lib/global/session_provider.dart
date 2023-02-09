import 'package:flutter/material.dart';

class SessionNotifier with ChangeNotifier {
  String username = '';
  String password = '';

  void updateCredentials(String username, String password) {
    this.username = username;
    this.password = password;
    notifyListeners();
  }
}
