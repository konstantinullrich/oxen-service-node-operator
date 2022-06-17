import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:oxen_service_node/src/oxen/service_node.dart';
import 'package:oxen_service_node/src/oxen/service_node_status.dart';
import 'package:oxen_service_node/src/stores/settings_store.dart';

part 'node_sync_store.g.dart';

class NodeSyncStore = NodeSyncStoreBase with _$NodeSyncStore;

abstract class NodeSyncStoreBase with Store {
  NodeSyncStoreBase(this._serviceNodes, this._settingsStore) : isSyncing = true;

  @action
  Future sync() async {
    isSyncing = true;
    final serviceNodePublicKeys =
        _serviceNodes.values.map((e) => e.publicKey).toList();
    try {
      final resultData =
          await _settingsStore.daemon.sendRPCRequest('get_service_nodes');
      final results = (resultData['result']['service_node_states'] as List);
      currentHeight = resultData['result']['height'] as int;
      networkSize =
          results.where((element) => element['active'] as bool).length;
      if (serviceNodePublicKeys.isNotEmpty) {
        final myNodes = results.where((element) =>
            serviceNodePublicKeys.contains(element['service_node_pubkey']));
        nodes = [];
        for (final result in myNodes) {
          final serviceNodeStatus = ServiceNodeStatus.load(result);
          final serviceNode = _serviceNodes.values.firstWhere((element) =>
              element.publicKey == serviceNodeStatus.nodeInfo.publicKey);
          if (!serviceNode.nodeInfo.equals(serviceNodeStatus.nodeInfo)) {
            serviceNode.nodeInfo = serviceNodeStatus.nodeInfo;
            await _serviceNodes.put(serviceNode.key, serviceNode);
          }
          nodes.add(serviceNodeStatus);
        }
      }
    } catch (e) {
      print(e);
      nodes = [];
      networkSize = 0;
      currentHeight = 0;
    }
    isSyncing = false;
  }

  @action
  Future startSync() async {
    print('[Oxen-Service-Node: Sync] Started');
    while (runSyncLoop) {
      await sync();
      print('[Oxen-Service-Node: Sync] Ran Sync');
      await Future.delayed(Duration(seconds: 20));
    }
    print('[Oxen-Service-Node: Sync] Stopped!!!!');
  }

  @action
  void stopSync() {
    runSyncLoop = false;
  }

  @observable
  bool runSyncLoop = true;

  @observable
  bool isSyncing;

  @observable
  int currentHeight;

  @observable
  int networkSize;

  @observable
  List<ServiceNodeStatus> nodes;

  SettingsStore _settingsStore;

  Box<ServiceNode> _serviceNodes;
}
