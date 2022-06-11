import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/utils/router/oxen_routes.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';
import 'package:oxen_service_node/src/oxen/service_node_status.dart';

class ServiceNodeCard extends StatefulWidget {
  ServiceNodeCard(
      this.name,
      this.serviceNodeKey,
      this.isUnlocking,
      this.active,
      this.isStorageServerReachable,
      this.isLokinetRouterReachable,
      this.lastRewardBlockHeight,
      this.earnedDowntimeBlocks,
      this.lastUptimeProof,
      this.contribution);

  final String name;
  final String serviceNodeKey;
  final bool isUnlocking;
  final bool active;
  final bool isStorageServerReachable;
  final bool isLokinetRouterReachable;
  final int lastRewardBlockHeight;
  final int earnedDowntimeBlocks;
  final DateTime lastUptimeProof;
  final Contribution contribution;

  final localeName = Platform.localeName; // Hack to fix Local 'built' has not been initialized

  @override
  State<StatefulWidget> createState() => _ServiceNodeCardState();
}

class _ServiceNodeCardState extends State<ServiceNodeCard> {
  static const int DECOMMISSION_MAX_CREDIT = 1440;

  var _tileExpanded = false;

  @override
  Widget build(BuildContext context) {
    final serviceNodeKey = widget.serviceNodeKey;
    final name = widget.name;
    final isUnlocking = widget.isUnlocking;
    final active = widget.active;
    final earnedDowntimeBlocks = widget.earnedDowntimeBlocks;
    final lastUptimeProof = widget.lastUptimeProof;
    final lastRewardBlockHeight = widget.lastRewardBlockHeight;
    final isStorageServerReachable = widget.isStorageServerReachable;
    final isLokinetRouterReachable = widget.isLokinetRouterReachable;
    final contribution = widget.contribution;

    final serviceNodeKeyShort =
        '${serviceNodeKey.substring(0, 12)}...${serviceNodeKey.substring(serviceNodeKey.length - 4)}';
    final partiallyStaked = contribution.totalContributed / 1000000000 < 15000;
    final remainingContribution = partiallyStaked
      ? ' (${(contribution.totalContributed / 1000000000).toInt()} / 15000 OXEN)'
      : '';
    final earnedDowntimeBlocksDisplay = partiallyStaked
      ? ''
      : ' ($earnedDowntimeBlocks / $DECOMMISSION_MAX_CREDIT ${S.of(context).blocks})';
    final statusIcon = isUnlocking
        ? Icon(Icons.access_time_sharp, color: OxenPalette.orange, size: 30)
        : (active
            ? Icon(Icons.check_circle_sharp,
                color: OxenPalette.iceBlue, size: 30)
            : Icon(Icons.error_sharp, color: OxenPalette.red, size: 30));

    return Card(
        child: ExpansionTile(
      leading: Padding(padding: EdgeInsets.all(5), child: statusIcon),
      trailing: Icon(
          _tileExpanded
              ? Icons.keyboard_arrow_up_sharp
              : Icons.keyboard_arrow_down_sharp,
          size: 30,
          color: Theme.of(context).primaryTextTheme.caption.color),
      onExpansionChanged: (bool expanded) {
        setState(() => _tileExpanded = expanded);
      },
      title: Text(name,
          style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).primaryTextTheme.caption.color)),
      subtitle: Text(
          '$serviceNodeKeyShort\n${S.of(context).uptime_proof}: ${lastUptimeProof.millisecondsSinceEpoch == 0 ? '-' : S.of(context).minutes_ago(DateTime.now().difference(lastUptimeProof).inMinutes)}${earnedDowntimeBlocksDisplay}\n${S.of(context).contributors}: ${contribution.contributors.length}${remainingContribution}',
          style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Theme.of(context).primaryTextTheme.caption.color)),
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
                          child: Text('$lastRewardBlockHeight',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20)),
                        )),
                    Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(S.of(context).last_reward,
                            textAlign: TextAlign.center,
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
                                isStorageServerReachable
                                    ? Icons.check_circle_sharp
                                    : Icons.error_sharp,
                                size: 30),
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(S.of(context).storage_server,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16)))
                    ])),
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
                                isLokinetRouterReachable
                                    ? Icons.check_circle_sharp
                                    : Icons.error_sharp,
                                size: 30),
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(S.of(context).lokinet_router,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16)))
                    ])),
          ),
          Expanded(
            flex: 1,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: 100,
                child: MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).pushNamed(
                      OxenRoutes.detailsServiceNode,
                      arguments: [serviceNodeKey, name]),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Icon(Icons.info_sharp, size: 30),
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text('${S.of(context).more}\n',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)))
                      ]),
                )),
          )
        ])
      ],
    ));
  }
}
