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
                final serviceNodeKeyShort =
                    '${serviceNodeKey.substring(0, 12)}...${serviceNodeKey.substring(serviceNodeKey.length - 4)}';
                final statusIcon = nodeStatus.isUnlocking
                    ? Icon(Icons.access_time_sharp,
                        color: OxenPalette.orange, size: 30)
                    : (nodeStatus.active
                        ? Icon(Icons.check_circle_sharp,
                            color: OxenPalette.lime, size: 30)
                        : Icon(Icons.error_sharp,
                            color: OxenPalette.red, size: 30));

                return Card(
                    child: ExpansionTile(
                  leading:
                      Padding(padding: EdgeInsets.all(5), child: statusIcon),
                  title: Text(
                    nodeSource.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(serviceNodeKeyShort),
                  children: [
                    Row(children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 1) * 0.25,
                          height: 100,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                          '${nodeStatus.lastReward.blockHeight}',
                                          style: TextStyle(fontSize: 20)),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(S.of(context).last_reward,
                                        style: TextStyle(fontSize: 16)))
                              ]),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 100,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Icon(
                                            nodeStatus.storageServer.isReachable
                                                ? Icons.check_circle_sharp
                                                : Icons.error_sharp,
                                            size: 30),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Text(S.of(context).storage_server,
                                          style: TextStyle(fontSize: 16)))
                                ])),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 100,
                            child: FlatButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Center(
                                          child:
                                              Icon(Icons.info_sharp, size: 30),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text(S.of(context).more,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal)))
                                  ]),
                            )),
                      )
                    ])
                  ],
                ));
              }),
        ],
      );
    });
  }
}
