import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/stores/node_sync_store.dart';
import 'package:oxen_service_node/src/utils/router/oxen_routes.dart';
import 'package:oxen_service_node/src/utils/short_address.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';
import 'package:oxen_service_node/src/widgets/base_page.dart';
import 'package:oxen_service_node/src/widgets/nav/nav_list_header.dart';
import 'package:oxen_service_node/src/widgets/nav/nav_list_multiheader.dart';
import 'package:oxen_service_node/src/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class DetailsServiceNodePage extends BasePage {
  DetailsServiceNodePage(this.publicKey, {required this.nodeName});

  final String publicKey;
  final String nodeName;

  static const int DECOMMISSION_MAX_CREDIT = 1440;
  static const int MINIMUM_CREDIT = 60;
  static const int AVERAGE_BLOCK_MINUTES = 2;

  String get title => this.nodeName;

  void copyToClipboard(String title, String data) {
    Clipboard.setData(ClipboardData(text: data));

    if (scaffoldKey.currentContext == null) return;

    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(S.current.copied_to_clipboard(title)),
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  DateTime estimatePastDateForHeight(int height) {
    return DateTime.now()
        .subtract(Duration(minutes: height * AVERAGE_BLOCK_MINUTES));
  }

  DateTime estimateFutureDateForHeight(int expectedAddedBlocks) {
    return DateTime.now()
        .add(Duration(minutes: expectedAddedBlocks * AVERAGE_BLOCK_MINUTES));
  }

  double estimateDowntimeHours(int earnedDowntimeBlocks) {
    return (earnedDowntimeBlocks / 60 * AVERAGE_BLOCK_MINUTES);
  }

  @override
  Widget body(BuildContext context) {
    final nodeSyncStatus = context.watch<NodeSyncStore>();
    final localeName = Platform.localeName;

    return ListView(
      children: [
        Observer(builder: (_) {
          final node = nodeSyncStatus.nodes
              .firstWhere((element) => element.nodeInfo.publicKey == publicKey);
          final nextReward = nodeSyncStatus.networkSize -
              (nodeSyncStatus.currentHeight - node.lastReward.blockHeight);
          final checkpoints = node.checkpointBlocks.checkpoints;
          checkpoints.sort((a, b) => b.height.compareTo(a.height));
          final pulses = node.pulseBlocks.pulses;
          pulses.sort((a, b) => b.height.compareTo(a.height));
          final contribution = node.contribution;

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (node.isUnlocking)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: 600,
                          child: Column(
                            children: [
                              Text(S.of(context).unlocking_node,
                                  style: TextStyle(fontSize: 30)),
                              Text(
                                  S.of(context).estimated_node_unlock(
                                      node.requestedUnlockHeight -
                                          nodeSyncStatus.currentHeight),
                                  style: TextStyle(fontSize: 20)),
                              Text(
                                  "~ ${DateFormat.yMMMd(localeName).add_jms().format(estimateFutureDateForHeight(node.requestedUnlockHeight - nodeSyncStatus.currentHeight))}",
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ),
                        color: OxenPalette.orange,
                      ),
                    ),
                  ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: 600,
                        child: Column(
                            children: contribution.totalContributed /
                                        1000000000 <
                                    15000
                                ? [
                                    Text(S.of(context).awaiting_contributions,
                                        style: TextStyle(fontSize: 30))
                                  ]
                                : [
                                    Text(S.of(context).next_reward,
                                        style: TextStyle(fontSize: 30)),
                                    Text(
                                        S
                                            .of(context)
                                            .estimated_reward_block(nextReward),
                                        style: TextStyle(fontSize: 20)),
                                    Text(
                                        "~ ${DateFormat.yMMMd(localeName).add_jms().format(estimateFutureDateForHeight(nextReward))}",
                                        style: TextStyle(fontSize: 20))
                                  ]),
                      ),
                      color: OxenPalette.teal,
                    ),
                  ),
                ),
                NavListMultiHeader(S.of(context).last_reward_height,
                    '${node.lastReward.blockHeight} (~ ${DateFormat.yMMMd(localeName).add_jm().format(estimatePastDateForHeight(nodeSyncStatus.currentHeight - node.lastReward.blockHeight))})'),
                NavListMultiHeader(
                    S.of(context).last_uptime_proof,
                    node.lastUptimeProof.millisecondsSinceEpoch == 0
                        ? '-'
                        : '${DateFormat.yMMMd(localeName).add_jms().format(node.lastUptimeProof)} (${S.of(context).minutes_ago(DateTime.now().difference(node.lastUptimeProof).inMinutes)})'),
                NavListMultiHeader(
                  S.of(context).earned_downtime_blocks,
                  '${node.earnedDowntimeBlocks} / $DECOMMISSION_MAX_CREDIT (${estimateDowntimeHours(node.earnedDowntimeBlocks).toStringAsFixed(2)} ${S.of(context).hours})',
                  subtitleColor: estimateDowntimeHours(node.earnedDowntimeBlocks) < 2 ? Colors.red : null,
                ),
                if (node.active)
                  Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Container(
                          child: Table(
                            children: [
                              TableRow(children: [
                                NavListHeader(S.of(context).checkpoints),
                                NavListHeader(S.of(context).pulses),
                              ]),
                              TableRow(children: [
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: checkpoints.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      padding: EdgeInsets.only(
                                          left: 20.0, right: 20.0),
                                      child: Text(
                                          checkpoints[index].height.toString(),
                                          style: TextStyle(
                                              color: checkpoints[index].voted
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontSize: 16.0)),
                                    );
                                  },
                                ),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: pulses.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      padding: EdgeInsets.only(
                                          left: 20.0, right: 20.0),
                                      child: Text(
                                          pulses[index].height.toString(),
                                          style: TextStyle(
                                              color: pulses[index].voted
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontSize: 16.0)),
                                    );
                                  },
                                ),
                              ])
                            ],
                          ),
                        ),
                      ])),
                Padding(padding: EdgeInsets.only(top: 15.0), child: Divider()),
                NavListMultiHeader(
                    S.of(context).public_ip, '${node.nodeInfo.ipAddress}',
                    onTap: () => copyToClipboard(
                        S.of(context).public_ip, node.nodeInfo.ipAddress)),
                NavListMultiHeader(
                    S.of(context).public_key, '${node.nodeInfo.publicKey}',
                    onTap: () => copyToClipboard(
                        S.of(context).public_key, node.nodeInfo.publicKey)),
                NavListMultiHeader(S.of(context).service_node_operator,
                    '${node.nodeInfo.operatorAddress}',
                    onTap: () => copyToClipboard(
                        S.of(context).service_node_operator,
                        node.nodeInfo.operatorAddress)),
                Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Container(
                        child: Table(
                          children: [
                            TableRow(children: [
                              NavListHeader(S.of(context).address),
                              NavListHeader(S.of(context).amount),
                            ]),
                            TableRow(children: [
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: contribution.contributors.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      padding: EdgeInsets.only(
                                          left: 20.0, right: 20.0),
                                      child: Text(
                                          '${contribution.contributors[index].address.toShortAddress()}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .headlineSmall
                                                  ?.color)));
                                },
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: contribution.contributors.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      padding: EdgeInsets.only(
                                          left: 20.0, right: 20.0),
                                      child: Text(
                                          '${contribution.contributors[index].amount ~/ 1000000000} (${(contribution.contributors[index].amount / 150000000000).toStringAsFixed(2)}%)',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .headlineSmall
                                                  ?.color)));
                                },
                              ),
                            ])
                          ],
                        ),
                      ),
                    ])),
                NavListMultiHeader(S.of(context).swarm_id, '${node.swarmId}',
                    forceSmallText: true),
                Padding(padding: EdgeInsets.only(top: 15.0), child: Divider()),
                NavListMultiHeader(S.of(context).registration_height,
                    '${node.nodeInfo.registrationHeight} (~ ${DateFormat.yMMMd(localeName).add_jm().format(estimatePastDateForHeight(nodeSyncStatus.currentHeight - node.nodeInfo.registrationHeight))})'),
                NavListMultiHeader(S.of(context).state_height,
                    '${node.stateHeight} (~ ${DateFormat.yMMMd(localeName).add_jm().format(estimatePastDateForHeight(nodeSyncStatus.currentHeight - node.stateHeight))})'),
                NavListMultiHeader(S.of(context).registration_hf_version,
                    '${node.nodeInfo.registrationHfVersion}'),
                NavListMultiHeader(S.of(context).software_versions,
                    '${node.nodeInfo.nodeVersion} / ${node.nodeInfo.storageServerVersion} / ${node.nodeInfo.lokinetVersion}'),
                Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 25),
                  child: PrimaryButton(
                    onPressed: () {
                      Navigator.pushNamed(context, OxenRoutes.editServiceNode,
                          arguments: publicKey);
                    },
                    text: S.of(context).title_edit_service_node,
                    color: Colors.transparent,
                    borderColor: Colors.transparent,
                    textColor: OxenPalette.teal,
                  ),
                ),
              ]);
        })
      ],
    );
  }
}
