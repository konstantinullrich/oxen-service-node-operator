import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:oxen_service_node/src/oxen/daemon.dart';
import 'package:oxen_service_node/src/utils/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_store.g.dart';

class SettingsStore = SettingsStoreBase with _$SettingsStore;

abstract class SettingsStoreBase with Store {
  SettingsStoreBase(this._sharedPreferences, this.isDarkTheme,
      this.languageCode, this._daemons);

  static const currentNodeIdKey = 'current_node_id';
  static const currentLanguageCodeKey = 'language_code';
  static const currentDarkThemeKey = 'dark_theme';

  static Future<SettingsStore> load(
      SharedPreferences sharedPreferences, Box<Daemon> daemons) async {
    final savedDarkTheme =
        sharedPreferences.getBool(currentDarkThemeKey) ?? false;
    final savedLanguageCode =
        sharedPreferences.getString(currentLanguageCodeKey) ??
            await Language.localeDetection();

    final store = SettingsStore(
        sharedPreferences, savedDarkTheme, savedLanguageCode, daemons);
    store.loadSettings();

    return store;
  }

  @observable
  bool isDarkTheme;

  @observable
  String languageCode;

  @observable
  Daemon daemon;

  Box<Daemon> _daemons;

  SharedPreferences _sharedPreferences;

  void loadSettings() {
    daemon = _fetchCurrentDaemon();
  }

  Daemon _fetchCurrentDaemon() {
    final id = _sharedPreferences.getInt(currentNodeIdKey) ?? 0;
    return _daemons.get(id);
  }
}
