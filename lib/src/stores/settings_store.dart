import 'package:mobx/mobx.dart';
import 'package:oxen_service_node/src/utils/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_store.g.dart';

class SettingsStore = SettingsStoreBase with _$SettingsStore;

abstract class SettingsStoreBase with Store {
  SettingsStoreBase(this.isDarkTheme, this.languageCode);

  static const currentNodeIdKey = 'current_node_id';
  static const currentLanguageCodeKey = 'language_code';
  static const currentDarkThemeKey = 'dark_theme';

  static Future<SettingsStore> load(SharedPreferences sharedPreferences) async {
    final savedDarkTheme =
        sharedPreferences.getBool(currentDarkThemeKey) ?? false;
    final savedLanguageCode =
        sharedPreferences.getString(currentLanguageCodeKey) ??
            await Language.localeDetection();

    return SettingsStore(savedDarkTheme, savedLanguageCode);
  }

  @observable
  bool isDarkTheme;

  @observable
  String languageCode;
}
