import 'package:hive/hive.dart';
import 'package:oxen_service_node/src/oxen/daemon.dart';
import 'package:oxen_service_node/src/oxen/service_node.dart';
import 'package:oxen_service_node/src/oxen/service_node_status.dart';
import 'package:oxen_service_node/src/stores/settings_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, input) async {
    final appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
    final serviceNodes = await Hive.openBox<ServiceNode>(ServiceNode.boxName);
    final daemons = await Hive.openBox<Daemon>(Daemon.boxName);
    final sharedPreferences = await SharedPreferences.getInstance();
    final settingsStore =
        await SettingsStoreBase.load(sharedPreferences, daemons);

    final serviceNodePublicKeys =
        serviceNodes.values.map((e) => e.publicKey).toList();

    print("Fuck IT!");
    final resultData =
        await settingsStore.daemon.sendRPCRequest('get_service_nodes');
    final results = (resultData['result']['service_node_states'] as List);
    if (serviceNodePublicKeys.isNotEmpty) {
      final myNodes = results.where((element) =>
          serviceNodePublicKeys.contains(element['service_node_pubkey']));
      for (final result in myNodes) {
        final serviceNodeStatus = ServiceNodeStatus.load(result);
        if (!serviceNodeStatus.isUnlocking && !serviceNodeStatus.active) {
          print("${serviceNodeStatus.nodeInfo.publicKey} is in trouble!");
        }
      }
    }
    return Future.value(true);
  });
}
