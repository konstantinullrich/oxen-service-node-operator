import 'package:shared_preferences/shared_preferences.dart';

class WelcomeManager {
  WelcomeManager(this._isSetup, this._sharedPreferences);

  static const initialAppStartKey = 'initial_app_start';

  static WelcomeManager load(SharedPreferences sharedPreferences) {
    final isInitialAppStart =
        sharedPreferences.getBool(initialAppStartKey) ?? false;
    return WelcomeManager(isInitialAppStart, sharedPreferences);
  }

  bool _isSetup;

  SharedPreferences _sharedPreferences;

  bool get isSetup => _isSetup;

  set isSetup(bool value) {
    _isSetup = value;
    _sharedPreferences.setBool(initialAppStartKey, value);
  }
}
