import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

part 'daemon.g.dart';

@HiveType(typeId: 0)
class Daemon extends HiveObject {
  Daemon(this.uri);

  Daemon.fromMap(Map map)
      : uri = (map['uri'] ?? '') as String;

  static const boxName = 'Daemons';

  @HiveField(0)
  String uri;

  Future<bool> isOnline() async {
    final resBody = await sendRPCRequest('get_info');
    return !(resBody['result']['offline'] as bool);
  }

  Future<Map<String, dynamic>> sendRPCRequest(String method,
      {Map params}) async {
    Map<String, dynamic> resultBody;

    final requestBody = params != null
        ? {'jsonrpc': '2.0', 'id': '0', 'method': method, 'params': params}
        : {'jsonrpc': '2.0', 'id': '0', 'method': method};

    final url = Uri.http(uri, '/json_rpc');
    final headers = {'Content-type': 'application/json'};
    final body = json.encode(requestBody);
    final response = await http.post(url, headers: headers, body: body);
    resultBody = json.decode(response.body) as Map<String, dynamic>;

    return resultBody;
  }
}
