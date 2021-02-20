import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/stores/node_sync_store.dart';
import 'package:oxen_service_node/src/widgets/base_page.dart';
import 'package:oxen_service_node/src/widgets/spinner.dart';
import 'package:provider/provider.dart';

class DashboardPage extends BasePage {
  @override
  String get title => S.current.title_dashboard;

  @override
  Widget leading(BuildContext context) {
    final nodeSyncStatus = Provider.of<NodeSyncStore>(context);

    nodeSyncStatus.sync();

    return Observer(builder: (_) {
      if (nodeSyncStatus.isSyncing)
        return Padding(
            padding: EdgeInsets.all(8),
            child: SizedBox(width: 34, child: Spinner(icon: Icons.sync)));
      return IconButton(
          icon: Icon(Icons.sync),
          onPressed: () {
            nodeSyncStatus.sync();
          });
    });
  }

  @override
  Widget body(BuildContext context) {
    final nodeSyncStatus = Provider.of<NodeSyncStore>(context);
    return Observer(builder: (_) {
      print(nodeSyncStatus.nodes.first.active);


      return Container();
    });
  }
}
