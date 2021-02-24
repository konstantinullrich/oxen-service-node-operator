import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:oxen_service_node/src/oxen/daemon.dart';
import 'package:oxen_service_node/src/oxen/service_node.dart';
import 'package:oxen_service_node/src/screens/dashboard_page.dart';
import 'package:oxen_service_node/src/screens/welcome_page.dart';
import 'package:oxen_service_node/src/stores/node_sync_store.dart';
import 'package:oxen_service_node/src/stores/settings_store.dart';
import 'package:oxen_service_node/src/utils/default_settings_migration.dart';
import 'package:oxen_service_node/src/utils/language.dart';
import 'package:oxen_service_node/src/utils/router/oxen_router.dart';
import 'package:oxen_service_node/src/utils/theme/theme_changer.dart';
import 'package:oxen_service_node/src/utils/theme/themes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  Hive.registerAdapter(ServiceNodeAdapter());
  Hive.registerAdapter(DaemonAdapter());

  final serviceNodes = await Hive.openBox<ServiceNode>(ServiceNode.boxName);
  final daemons = await Hive.openBox<Daemon>(Daemon.boxName);
  final sharedPreferences = await SharedPreferences.getInstance();

  await defaultSettingsMigration(1, sharedPreferences, daemons);

  final settingsStore =
      await SettingsStoreBase.load(sharedPreferences, daemons);
  final nodeSyncStore = NodeSyncStore(serviceNodes, settingsStore);

  if (serviceNodes.isNotEmpty) await nodeSyncStore.sync();

  runApp(MultiProvider(providers: [
    Provider(create: (_) => serviceNodes),
    Provider(create: (_) => daemons),
    Provider(create: (_) => sharedPreferences),
    Provider(create: (_) => settingsStore),
    Provider(create: (_) => nodeSyncStore),
  ], child: OxenServiceNodeApp()));
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
    final serviceNodes = Provider.of<Box<ServiceNode>>(context);
    final statusBarColor =
        settingsStore.isDarkTheme ? Colors.black : Colors.white;

    final isSetup = serviceNodes.isEmpty;

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
            settings, sharedPreferences, settingsStore),
        home: isSetup ? WelcomePage() : DashboardPage());
  }
}
