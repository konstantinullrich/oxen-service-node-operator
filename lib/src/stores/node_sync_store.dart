import 'dart:io';
import 'dart:isolate';

import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:oxen_service_node/src/oxen/daemon.dart';
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
      nodes = [];
      networkSize = 0;
      currentHeight = 0;
    }
    isSyncing = false;
  }

  Future startSync() async {
    print('[Sync] Started');
    while (runSyncLoop) {
      await sync();
      print('[Sync] Ran Sync');
      sleep(Duration(seconds: 1));
    }
    print('[Sync] Stopped!!!!');
  }

  void stopSync() {
    runSyncLoop = false;
  }

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

  Isolate _syncLoop;

  ReceivePort _syncReceivePort;
}

class SyncLoopArgs {
  SyncLoopArgs(this.sendPort, this.daemon, this.serviceNodePublicKeys);

  final SendPort sendPort;
  final Daemon daemon;
  final List<String> serviceNodePublicKeys;
}

class SyncLoopResults {
  SyncLoopResults(this.currentHeight, this.nodes, this.networkSize);

  final int currentHeight;
  final List<ServiceNodeStatus> nodes;
  final int networkSize;
}

Future syncLoopProcess(SyncLoopArgs syncLoopArgs) async {
  while (true) {
    var currentHeight = 0;
    var networkSize = 0;
    var nodes = [];
    try {
      final resultData =
          await syncLoopArgs.daemon.sendRPCRequest('get_service_nodes');
      final results = (resultData['result']['service_node_states'] as List);
      currentHeight = resultData['result']['height'] as int;
      networkSize =
          results.where((element) => element['active'] as bool).length;
      if (syncLoopArgs.serviceNodePublicKeys.isNotEmpty) {
        nodes = results
            .where((element) => syncLoopArgs.serviceNodePublicKeys
                .contains(element['service_node_pubkey']))
            .map((e) => ServiceNodeStatus.load(e))
            .toList();
      }
    } catch (e) {}
    syncLoopArgs.sendPort
        .send(SyncLoopResults(currentHeight, nodes, networkSize));
    sleep(Duration(seconds: 2));
  }
}
