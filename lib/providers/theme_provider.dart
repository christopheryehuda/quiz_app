import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  /// Balik tema berdasarkan tema yang sedang tampil.
  void toggle(Brightness currentBrightness) {
    _themeMode = currentBrightness == Brightness.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    notifyListeners();
  }
}