import 'package:flutter/material.dart';
import 'package:untitled19/provider/darktheme-preference.dart';
class DarkThemeProvider extends ChangeNotifier{
  DarkThemePreferences darkThemePreferences =DarkThemePreferences();
  bool _darkTheme=false;
  bool get darkTheme => _darkTheme;
  set darkTheme (bool value){
    _darkTheme=value;
    darkThemePreferences.setDarkTheme(value);
    notifyListeners();
  }
}