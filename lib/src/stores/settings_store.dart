import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:oxen_service_node/src/oxen/daemon.dart';
import 'package:oxen_service_node/src/utils/dashboard_sort_order.dart';
import 'package:oxen_service_node/src/utils/language.dart';
import 'package:oxen_service_node/src/utils/theme/theme_changer.dart';
import 'package:oxen_service_node/src/utils/theme/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_store.g.dart';

class SettingsStore = SettingsStoreBase with _$SettingsStore;

abstract class SettingsStoreBase with Store {
  SettingsStoreBase(this._sharedPreferences, this._daemons, this.isDarkTheme,
      this.languageCode, this.dashboardOrderBy);

  static const currentNodeIdKey = 'current_node_id';
  static const currentLanguageCodeKey = 'language_code';
  static const currentDarkThemeKey = 'dark_theme';
  static const currentDashboardOrderBy = 'dashboard_sort_order';

  static Future<SettingsStore> load(
      SharedPreferences sharedPreferences, Box<Daemon> daemons) async {
    final savedDarkTheme =
        sharedPreferences.getBool(currentDarkThemeKey) ?? false;
    final savedLanguageCode =
        sharedPreferences.getString(currentLanguageCodeKey) ??
            await Language.localeDetection();

    final savedDashboardOrderBy = DashboardOrderBy.parse(
            sharedPreferences.getString(currentDashboardOrderBy) ?? DashboardOrderBy.NAME.name);

    final store = SettingsStore(sharedPreferences, daemons, savedDarkTheme,
        savedLanguageCode, savedDashboardOrderBy);
    store.loadSettings();

    return store;
  }

  @observable
  bool isDarkTheme;

  @observable
  String languageCode;

  @observable
  Daemon? daemon;

  @observable
  DashboardOrderBy dashboardOrderBy;

  Box<Daemon> _daemons;

  SharedPreferences _sharedPreferences;

  ThemeChanger? themeChanger;

  Language? language;

  void loadSettings() {
    daemon = _fetchCurrentDaemon()!;
  }

  Daemon? _fetchCurrentDaemon() {
    final id = _sharedPreferences.getInt(currentNodeIdKey) ?? 0;
    return _daemons.get(id);
  }

  @action
  Future<void> toggleDarkTheme() async {
    isDarkTheme = !isDarkTheme;
    if (themeChanger != null)
      themeChanger!.theme = isDarkTheme ? Themes.darkTheme : Themes.lightTheme;
    await _sharedPreferences.setBool(currentDarkThemeKey, isDarkTheme);
  }

  @action
  Future setLanguageCode(String newLanguageCode) async {
    languageCode = newLanguageCode;
    if (language != null) language!.currentLanguage = languageCode;
    await _sharedPreferences.setString(currentLanguageCodeKey, languageCode);
  }

  @action
  Future setDaemon(Daemon newDaemon) async {
    daemon = newDaemon;
    await _sharedPreferences.setInt(currentNodeIdKey, daemon?.key);
  }

  @action
  Future setDashboardOrderBy(DashboardOrderBy newDashboardSortOrder) async {
    dashboardOrderBy = newDashboardSortOrder;
    await _sharedPreferences.setString(
        currentDashboardOrderBy, dashboardOrderBy.name);
  }
}
