import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:oxen_service_node/src/oxen/daemon.dart';
import 'package:oxen_service_node/src/oxen/daemon_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future defaultSettingsMigration(int version,
    SharedPreferences sharedPreferences, Box<Daemon> daemons) async {
  final currentVersion =
      sharedPreferences.getInt('current_default_settings_migration_version') ??
          0;

  if (currentVersion >= version) {
    return;
  }

  final migrationVersionsLength = version - currentVersion;
  final migrationVersions = List<int>.generate(
      migrationVersionsLength, (i) => currentVersion + (i + 1));

  await Future.forEach(migrationVersions, (int version) async {
    try {
      switch (version) {
        case 1:
          await resetToDefault(daemons);
          await changeCurrentNodeToDefault(
              sharedPreferences: sharedPreferences, nodes: daemons);
          break;
        default:
          break;
      }

      await sharedPreferences.setInt(
          'current_default_settings_migration_version', version);
    } catch (e) {
      print('Migration error: ${e.toString()}');
    }
  });

  await sharedPreferences.setInt(
      'current_default_settings_migration_version', version);
}

Future<void> changeCurrentNodeToDefault(
    {@required SharedPreferences sharedPreferences,
    @required Box<Daemon> nodes}) async {
  final timeZone = DateTime.now().timeZoneOffset.inHours;
  var nodeUri = '';

  if (timeZone >= 1) {
    // Eurasia
    nodeUri = 'public.loki.foundation:22023';
  } else if (timeZone <= -4) {
    // America
    nodeUri = 'freyr.imaginary.stream:22023';
  }

  final node =
      nodes.values.firstWhere((Daemon daemon) => daemon.uri == nodeUri) ??
          nodes.values.first;
  final nodeId = node != null ? node.key as int : 0; // 0 - England

  await sharedPreferences.setInt('current_node_id', nodeId);
}
