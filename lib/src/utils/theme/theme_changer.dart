import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeChanger(this._themeData);

  ThemeData _themeData;

  ThemeData get theme => _themeData;

  set theme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
