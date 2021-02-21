import 'package:flutter/material.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:intl/intl.dart';

const Map<String, String> languages = {
  'en': 'English',
  'de': 'Deutsch'
};

class Language with ChangeNotifier {
  Language(this._currentLanguage);

  String _currentLanguage;

  String get currentLanguage => _currentLanguage;

  set currentLanguage(String language) {
    _currentLanguage = language;
    notifyListeners();
  }

  static Future<String> localeDetection() async {
    var locale = await Devicelocale.currentLocale;
    locale = Intl.shortLocale(locale);

    return languages.keys.contains(locale) ? locale : 'en';
  }
}
