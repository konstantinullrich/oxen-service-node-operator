import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/stores/node_sync_store.dart';
import 'package:oxen_service_node/src/utils/router/oxen_routes.dart';
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

    return SizedBox(
      width: 30,
      child: Observer(builder: (_) {
        if (nodeSyncStatus.isSyncing) return Spinner(icon: Icons.sync);
        return FlatButton(
            padding: EdgeInsets.all(0),
            child: Icon(Icons.sync,
                color: Theme.of(context).primaryTextTheme.caption.color,
                size: 24),
            onPressed: () {
              nodeSyncStatus.sync();
            });
      }),
    );
  }

  @override
  Widget trailing(BuildContext context) {
    return SizedBox(
      width: 30,
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () =>
              // Navigator.of(context).pushNamed(OxenRoutes.addServiceNode),
              // Navigator.of(context).pushNamed(OxenRoutes.addDaemon),
              Navigator.of(context).pushNamed(OxenRoutes.settings),
          child: Icon(Icons.settings_sharp,
              color: Theme.of(context).primaryTextTheme.caption.color,
              size: 24)),
    );
  }

  @override
  Widget body(BuildContext context) {
    final nodeSyncStatus = Provider.of<NodeSyncStore>(context);
    return Observer(builder: (_) {
      return Container();
    });
  }
}
