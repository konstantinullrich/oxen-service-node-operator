import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/stores/node_sync_store.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';
import 'package:oxen_service_node/src/widgets/base_page.dart';
import 'package:oxen_service_node/src/widgets/nav/nav_list_multiheader.dart';
import 'package:oxen_service_node/src/widgets/nav/nav_list_progress.dart';
import 'package:provider/provider.dart';

class DetailsServiceNodePage extends BasePage {
  DetailsServiceNodePage(this.publicKey);

  final String publicKey;

  static const int DECOMMISSION_MAX_CREDIT = 1440;
  static const int MINIMUM_CREDIT = 60;

  @override
  Widget body(BuildContext context) {
    final nodeSyncStatus = Provider.of<NodeSyncStore>(context);

    return ListView(
      children: [
        Observer(builder: (_) {
          final node = nodeSyncStatus.nodes
              .firstWhere((element) => element.nodeInfo.publicKey == publicKey);
          final nextReward = nodeSyncStatus.networkSize -
              (nodeSyncStatus.currentHeight - node.lastReward.blockHeight);

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
                                  style: TextStyle(fontSize: 30))
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
                          children: [
                            Text(S.of(context).next_reward,
                                style: TextStyle(fontSize: 30)),
                            Text(
                                S
                                    .of(context)
                                    .estimated_reward_block(nextReward),
                                style: TextStyle(fontSize: 30))
                          ],
                        ),
                      ),
                      color: OxenPalette.teal,
                    ),
                  ),
                ),
                NavListMultiHeader(S.of(context).last_reward_height,
                    '${node.lastReward.blockHeight}'),
                NavListMultiHeader(S.of(context).last_uptime_proof,
                    '${node.lastUptimeProof.toLocal()}'),
                NavListProgress(S.of(context).earned_downtime_blocks,
                    node.earnedDowntimeBlocks, DECOMMISSION_MAX_CREDIT,
                    threshold: MINIMUM_CREDIT),
                Padding(padding: EdgeInsets.only(top: 15.0), child: Divider()),
                NavListMultiHeader(
                    S.of(context).public_key, '${node.nodeInfo.publicKey}'),
                NavListMultiHeader(S.of(context).service_node_operator,
                    '${node.nodeInfo.operatorAddress}'),
                NavListMultiHeader(S.of(context).swarm_id, '${node.swarmId}'),
                Padding(padding: EdgeInsets.only(top: 15.0), child: Divider()),
                NavListMultiHeader(S.of(context).registration_height,
                    '${node.nodeInfo.registrationHeight}'),
                NavListMultiHeader(S.of(context).registration_hf_version,
                    '${node.nodeInfo.registrationHfVersion}'),
                NavListMultiHeader(S.of(context).service_node_version,
                    '${node.nodeInfo.version}'),
              ]);
        })
      ],
    );
  }
}
