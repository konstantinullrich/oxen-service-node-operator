import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:oxen_service_node/src/oxen/daemon.dart';
import 'package:yaml/yaml.dart';

Future<List<Daemon>> loadDefaultNodes() async {
  final nodesRaw = await rootBundle.loadString('assets/daemon_list.yml');
  final nodes = loadYaml(nodesRaw) as YamlList;

  return nodes.map((dynamic raw) {
    if (raw is Map) {
      return Daemon.fromMap(raw);
    }
    return null;
  }).whereType<Daemon>().toList();
}

Future resetToDefault(Box<Daemon> nodeSource) async {
  final nodes = await loadDefaultNodes() ?? [];
  final entities = <int, Daemon>{};

  await nodeSource.clear();

  for (var i = 0; i < nodes.length; i++) {
    entities[i] = nodes[i];
  }

  await nodeSource.putAll(entities);
}
