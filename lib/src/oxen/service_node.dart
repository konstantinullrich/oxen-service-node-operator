import 'package:hive/hive.dart';
import 'package:oxen_service_node/src/oxen/service_node_status.dart';

part 'service_node.g.dart';

@HiveType(typeId: 1)
class ServiceNode extends HiveObject {
  ServiceNode(this.name, this.publicKey);

  ServiceNode.fromMap(Map map)
      : name = (map['name'] ?? '') as String,
        publicKey = (map['publicKey'] ?? '') as String;

  static const boxName = 'ServiceNodes';

  @HiveField(0)
  String name;

  @HiveField(1)
  String publicKey;

  @HiveField(2)
  late String operatorAddress;

  @HiveField(3)
  late int registrationHeight;

  @HiveField(4)
  late int registrationHfVersion;

  @HiveField(5)
  late String nodeVersion;

  @HiveField(6)
  late String ipAddress;

  @HiveField(7)
  late String storageServerVersion;

  @HiveField(8)
  late String lokinetVersion;

  ServiceNodeInfo get nodeInfo => ServiceNodeInfo(
      operatorAddress,
      registrationHeight,
      registrationHfVersion,
      publicKey,
      ipAddress,
      nodeVersion,
      storageServerVersion,
      lokinetVersion);

  set nodeInfo(ServiceNodeInfo value) {
    operatorAddress = value.operatorAddress;
    registrationHeight = value.registrationHeight;
    registrationHfVersion = value.registrationHfVersion;
    nodeVersion = value.nodeVersion;
    storageServerVersion = value.storageServerVersion;
    lokinetVersion = value.lokinetVersion;
    ipAddress = value.ipAddress;
  }
}
