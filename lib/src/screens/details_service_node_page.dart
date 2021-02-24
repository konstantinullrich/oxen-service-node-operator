import 'package:flutter/material.dart';
import 'package:oxen_service_node/src/stores/node_sync_store.dart';
import 'package:oxen_service_node/src/widgets/base_page.dart';
import 'package:provider/provider.dart';

class DetailsServiceNodePage extends BasePage {
  DetailsServiceNodePage(this.publicKey);

  final String publicKey;

  @override
  String get title => publicKey.substring(0, 20); // TODO: implement title

  @override
  Widget body(BuildContext context) {
    final nodeSyncStatus = Provider.of<NodeSyncStore>(context);
    final node = nodeSyncStatus.nodes
        .firstWhere((element) => element.nodeInfo.publicKey == publicKey);
    // TODO: implement body
    return Container();
  }
}
