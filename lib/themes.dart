import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themedata = ThemeData.light();
  ThemeData getTheme() => _themedata;

  ThemeNotifier() {
    getThemeSetting().then((value) {
      var themeMode = value ?? false;
      if (themeMode == false) {
        _themedata = ThemeData.light();
      } else {
        _themedata = ThemeData.dark();
      }
      notifyListeners();
    });
  }

  void setLightMode() {
    _themedata = ThemeData.light();
    setThemeSetting(false);
    notifyListeners();
  }

  void setDarkMode() {
    _themedata = ThemeData.dark();
    setThemeSetting(true);
    notifyListeners();
  }

  Future<Object?> getThemeSetting() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get("darkTheme");
  }

  void setThemeSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkTheme', value);
    getThemeSetting().then((value) => print(value));
  }
}
