import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLanguage(String languageCode) {
    _locale = Locale(languageCode);
    notifyListeners();
  }

  void toggleLanguage() {
    _locale = _locale.languageCode == 'en' ? const Locale('nl') : const Locale('en');
    notifyListeners();
  }
}
