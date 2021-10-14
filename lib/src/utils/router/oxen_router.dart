import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/screens/add_new_daemon_page.dart';
import 'package:oxen_service_node/src/screens/add_new_service_node_page.dart';
import 'package:oxen_service_node/src/screens/change_language_page.dart';
import 'package:oxen_service_node/src/screens/changelog_page.dart';
import 'package:oxen_service_node/src/screens/dashboard_page.dart';
import 'package:oxen_service_node/src/screens/details_service_node_page.dart';
import 'package:oxen_service_node/src/screens/edit_daemons.dart';
import 'package:oxen_service_node/src/screens/edit_service_nodes.dart';
import 'package:oxen_service_node/src/screens/settings_page.dart';
import 'package:oxen_service_node/src/screens/welcome_page.dart';
import 'package:oxen_service_node/src/stores/settings_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'oxen_routes.dart';

class OxenRouter {
  static Route<dynamic> generateRoute(RouteSettings settings,
      SharedPreferences sharedPreferences, SettingsStore settingsStore) {
    switch (settings.name) {
      case OxenRoutes.welcome:
        return MaterialPageRoute<void>(builder: (_) => WelcomePage());

      case OxenRoutes.addServiceNode:
        return CupertinoPageRoute<void>(
            builder: (_) => AddNewServiceNodePage());

      case OxenRoutes.addDaemon:
        return CupertinoPageRoute<void>(builder: (_) => AddNewDaemonPage());

      case OxenRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => DashboardPage());

      case OxenRoutes.settings:
        return CupertinoPageRoute(builder: (_) => SettingsPage());

      case OxenRoutes.settingsLanguage:
        return CupertinoPageRoute(builder: (_) => ChangeLanguagePage());

      case OxenRoutes.settingsDaemon:
        return CupertinoPageRoute(builder: (_) => EditDaemonsPage());

      case OxenRoutes.settingsChangelog:
        return CupertinoPageRoute(builder: (_) => ChangelogPage());

      case OxenRoutes.settingsServiceNode:
        return CupertinoPageRoute(builder: (_) => EditServiceNodesPage());

      case OxenRoutes.detailsServiceNode:
        return CupertinoPageRoute(builder: (_) {
          List<String> args = settings.arguments;
          String nodeName = args.length > 1 ? args[1] : null;
          return DetailsServiceNodePage(args.first, nodeName: nodeName);
        });

      default:
        return MaterialPageRoute<void>(
            builder: (_) => Scaffold(
                  body: Center(
                      child:
                          Text(S.current.error_router_no_route(settings.name))),
                ));
    }
  }
}
