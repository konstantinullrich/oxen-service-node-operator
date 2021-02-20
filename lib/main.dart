import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oxen_service_node/src/screens/welcome_page.dart';
import 'package:oxen_service_node/src/stores/settings_store.dart';
import 'package:oxen_service_node/src/utils/language.dart';
import 'package:oxen_service_node/src/utils/router/oxen_router.dart';
import 'package:oxen_service_node/src/utils/theme/theme_changer.dart';
import 'package:oxen_service_node/src/utils/theme/themes.dart';
import 'package:oxen_service_node/src/utils/welcome_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final settingsStore = await SettingsStoreBase.load(sharedPreferences);

  runApp(MultiProvider(
      providers: [
        Provider(create: (_) => sharedPreferences),
        Provider(create: (_) => settingsStore)
      ],
      child: OxenServiceNodeApp()));
}

class OxenServiceNodeApp extends StatelessWidget {
  OxenServiceNodeApp() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);

    return ChangeNotifierProvider<ThemeChanger>(
        create: (_) => ThemeChanger(
            settingsStore.isDarkTheme ? Themes.darkTheme : Themes.lightTheme),
        child: ChangeNotifierProvider<Language>(
            create: (_) => Language(settingsStore.languageCode),
            child: MaterialAppWithTheme()));
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sharedPreferences = Provider.of<SharedPreferences>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final currentLanguage = Provider.of<Language>(context);
    final theme = Provider.of<ThemeChanger>(context);
    final statusBarColor =
        settingsStore.isDarkTheme ? Colors.black : Colors.white;
    final welcomeManager = WelcomeManager.load(sharedPreferences);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: statusBarColor));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.theme,
        localizationsDelegates: [
          S.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: Locale(currentLanguage.currentLanguage),
        onGenerateRoute: (settings) => OxenRouter.generateRoute(
          settings, sharedPreferences, settingsStore, welcomeManager),
        home: WelcomePage());
  }
}
