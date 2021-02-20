import 'package:hive/hive.dart';

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
}
