import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  String _selectedTheme = 'hammenga';

  String get selectedTheme => _selectedTheme;

  Color get primaryColor {
    switch (_selectedTheme) {
      case 'eco_agency':
        return const Color(0xFF16A34A); // Green
      case 'creative':
        return const Color(0xFF9D4EDD); // Purple
      case 'hammenga':
      default:
        return const Color(0xFF2563EB); // Blue
    }
  }

  Color get secondaryColor {
    switch (_selectedTheme) {
      case 'eco_agency':
        return const Color(0xFFDCFCE7); // Light Green
      case 'creative':
        return const Color(0xFFE0AAFF); // Light Purple
      case 'hammenga':
      default:
        return const Color(0xFFDEBEFC); // Light Blue
    }
  }

  void setTheme(String theme) {
    _selectedTheme = theme;
    notifyListeners();
  }
}
