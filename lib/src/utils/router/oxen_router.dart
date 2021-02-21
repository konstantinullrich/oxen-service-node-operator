import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/screens/add_new_daemon_page.dart';
import 'package:oxen_service_node/src/screens/add_new_node_page.dart';
import 'package:oxen_service_node/src/screens/change_language_page.dart';
import 'package:oxen_service_node/src/screens/dashboard_page.dart';
import 'package:oxen_service_node/src/screens/edit_daemons.dart';
import 'package:oxen_service_node/src/screens/settings_page.dart';
import 'package:oxen_service_node/src/screens/welcome_page.dart';
import 'package:oxen_service_node/src/stores/settings_store.dart';
import 'package:oxen_service_node/src/utils/welcome_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'oxen_routes.dart';

class OxenRouter {
  static Route<dynamic> generateRoute(
      RouteSettings settings,
      SharedPreferences sharedPreferences,
      SettingsStore settingsStore,
      WelcomeManager welcomeManager) {
    switch (settings.name) {
      case OxenRoutes.welcome:
        return MaterialPageRoute<void>(builder: (_) => WelcomePage());

      case OxenRoutes.addServiceNodeFromWelcome:
        welcomeManager.isSetup = false;
        return CupertinoPageRoute<void>(builder: (_) => AddNewNodePage());

      case OxenRoutes.addServiceNode:
        return CupertinoPageRoute<void>(builder: (_) => AddNewNodePage());

      case OxenRoutes.addDaemon:
        return CupertinoPageRoute<void>(builder: (_) => AddNewDaemonPage());

      case OxenRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => DashboardPage());

      case OxenRoutes.settings:
        return CupertinoPageRoute(builder: (_) => SettingsPage());

      case OxenRoutes.settings_language:
        return CupertinoPageRoute(builder: (_) => ChangeLanguagePage());

      case OxenRoutes.settings_daemon:
        return CupertinoPageRoute(builder: (_) => EditDaemonsPage());

      default:
        return MaterialPageRoute<void>(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text(S.current.error_router_no_route(settings.name))),
                ));
    }
  }
}
