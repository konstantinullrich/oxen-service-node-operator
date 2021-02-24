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
    if (serviceNodePublicKeys.isNotEmpty) {
      final params = {'service_node_pubkeys': serviceNodePublicKeys};
      try {
        final resultData = await _settingsStore.daemon
            .sendRPCRequest('get_service_nodes', params: params);
        final results = resultData['result']['service_node_states'] as List;
        currentHeight = resultData['result']['height'] as int;
        nodes = [];
        for (final result in results) {
          final serviceNodeStatus = ServiceNodeStatus.load(result);
          final serviceNode = _serviceNodes.values.firstWhere((element) =>
              element.publicKey == serviceNodeStatus.nodeInfo.publicKey);
          if (!serviceNode.nodeInfo.equals(serviceNodeStatus.nodeInfo)) {
            serviceNode.nodeInfo = serviceNodeStatus.nodeInfo;
            await _serviceNodes.put(serviceNode.key, serviceNode);
          }
          nodes.add(serviceNodeStatus);
        }
      } catch (e) {
        currentHeight = 0;
        nodes = [];
      }
    }
    isSyncing = false;
  }

  @observable
  bool isSyncing;

  @observable
  int currentHeight;

  @observable
  List<ServiceNodeStatus> nodes;

  SettingsStore _settingsStore;

  Box<ServiceNode> _serviceNodes;
}
