import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/screens/add_new_node_page.dart';
import 'package:oxen_service_node/src/screens/welcome_page.dart';
import 'package:oxen_service_node/src/stores/settings_store.dart';
import 'package:oxen_service_node/src/utils/welcome_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'oxen_routes.dart';

class OxenRouter {
  static Route<dynamic> generateRoute(RouteSettings settings, SharedPreferences sharedPreferences, SettingsStore settingsStore, WelcomeManager welcomeManager) {
    switch (settings.name) {
      case OxenRoutes.welcome:
        return MaterialPageRoute<void>(builder: (_) => WelcomePage());

      case OxenRoutes.addServiceNodeFromWelcome:
        welcomeManager.isSetup = false;
        return CupertinoPageRoute<void>(
            builder: (_) => AddNewNodePage());

      default:
        return MaterialPageRoute<void>(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text(S.current.router_no_route(settings.name))),
            ));
    }
  }
}
