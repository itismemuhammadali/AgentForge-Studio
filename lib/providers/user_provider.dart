import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _firstName = 'Gerald';
  String _lastName = 'Hendrix';
  String _userRole = 'client'; // 'client' or 'admin'

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get userRole => _userRole;

  void setUserInfo({
    required String firstName,
    required String lastName,
    required String userRole,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _userRole = userRole;
    notifyListeners();
  }

  void updateFirstName(String firstName) {
    _firstName = firstName;
    notifyListeners();
  }

  void updateLastName(String lastName) {
    _lastName = lastName;
    notifyListeners();
  }

  void setUserRole(String role) {
    _userRole = role;
    notifyListeners();
  }
}
