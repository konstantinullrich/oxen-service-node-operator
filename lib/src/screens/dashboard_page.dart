import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/oxen/service_node.dart';
import 'package:oxen_service_node/src/oxen/service_node_status.dart';
import 'package:oxen_service_node/src/stores/node_sync_store.dart';
import 'package:oxen_service_node/src/utils/router/oxen_routes.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';
import 'package:oxen_service_node/src/widgets/base_page.dart';
import 'package:oxen_service_node/src/widgets/service_node_card.dart';
import 'package:oxen_service_node/src/widgets/spinner.dart';
import 'package:provider/provider.dart';

class OperatorStatus {
  OperatorStatus(this.healthyNodes, this.unhealthyNodes);

  final int healthyNodes;
  final int unhealthyNodes;

  static OperatorStatus load(List<ServiceNodeStatus> nodes) {
    var healthyNodes = 0;
    var unhealthyNodes = 0;

    if (nodes != null) {
      for (final node in nodes) {
        if (node.active && node.funded)
          healthyNodes++;
        else
          unhealthyNodes++;
      }
    }

    return OperatorStatus(healthyNodes, unhealthyNodes);
  }

  int get totalNodes => healthyNodes + unhealthyNodes;

  double get healthPercentage => totalNodes > 0 ? healthyNodes / totalNodes : 1;
}

class DashboardPage extends BasePage {
  @override
  String get title => S.current.title_dashboard;

  @override
  Widget leading(BuildContext context) {
    final nodeSyncStatus = Provider.of<NodeSyncStore>(context);
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
          onPressed: () => Navigator.of(context).pushNamed(OxenRoutes.settings),
          child: Icon(Icons.settings_sharp,
              color: Theme.of(context).primaryTextTheme.caption.color,
              size: 24)),
    );
  }

  @override
  Widget body(BuildContext context) {
    final nodeSyncStatus = Provider.of<NodeSyncStore>(context);
    final nodes = Provider.of<Box<ServiceNode>>(context);

    return Observer(builder: (_) {
      final operatorStatus = OperatorStatus.load(nodeSyncStatus.nodes);

      final operatorStatusText = operatorStatus.healthPercentage == 1.0
          ? S.of(context).health_all_nodes
          : (operatorStatus.healthPercentage == 0
              ? S.of(context).health_no_nodes
              : S.of(context).health_out_of_nodes(
                  operatorStatus.healthyNodes, operatorStatus.totalNodes));

      return ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18, bottom: 28),
            child: SizedBox(
              height: 220.0,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        strokeWidth: 15,
                        value: operatorStatus.healthPercentage,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(OxenPalette.lime),
                        backgroundColor: OxenPalette.red,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(operatorStatusText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0, color: Palette.wildDarkBlue)),
                  )
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 28),
              child: Text(
                S.of(context).your_service_nodes,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, color: Palette.wildDarkBlue),
              )),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: nodeSyncStatus.nodes != null
                  ? nodeSyncStatus.nodes.length
                  : 0,
              itemBuilder: (BuildContext context, int index) {
                final nodeStatus = nodeSyncStatus.nodes[index];
                final serviceNodeKey = nodeStatus.nodeInfo.publicKey;
                final nodeSource = nodes.values.firstWhere((e) {
                  return e.publicKey == serviceNodeKey;
                });
                return ServiceNodeCard(
                    nodeSource.name,
                    serviceNodeKey,
                    nodeStatus.isUnlocking,
                    nodeStatus.active,
                    nodeStatus.storageServer.isReachable,
                    nodeStatus.lastReward.blockHeight);
              }),
        ],
      );
    });
  }
}
