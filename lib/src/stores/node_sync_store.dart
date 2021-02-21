import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:oxen_service_node/src/oxen/service_node.dart';
import 'package:oxen_service_node/src/oxen/service_node_status.dart';
import 'package:oxen_service_node/src/stores/settings_store.dart';

part 'node_sync_store.g.dart';

class NodeSyncStore = NodeSyncStoreBase with _$NodeSyncStore;

abstract class NodeSyncStoreBase with Store {
  NodeSyncStoreBase(this._serviceNodes, this._settingsStore) : isSyncing = true;

  Future sync() async {
    isSyncing = true;
    final serviceNodePublicKeys =
    _serviceNodes.values.toList().map((e) => e.publicKey).toList();
    if (serviceNodePublicKeys.isNotEmpty) {
      final params = {'service_node_pubkeys': serviceNodePublicKeys};
      final resultData = await _settingsStore.daemon
          .sendRPCRequest('get_service_nodes', params: params);
      try {
        final result = resultData['result']['service_node_states'] as List;
        nodes = result.map((e) => ServiceNodeStatus.load(e)).toList();
      } catch (e) {
        nodes = [];
      }
    }
    isSyncing = false;
  }

  @observable
  bool isSyncing;

  @observable
  List<ServiceNodeStatus> nodes;

  SettingsStore _settingsStore;

  Box<ServiceNode> _serviceNodes;
}
