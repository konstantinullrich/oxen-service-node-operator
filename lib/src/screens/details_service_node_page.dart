import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/stores/node_sync_store.dart';
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
  String get title => publicKey.substring(0, 20); // TODO: implement title

  @override
  Widget body(BuildContext context) {
    final nodeSyncStatus = Provider.of<NodeSyncStore>(context);
    // TODO: implement body
    return ListView(
      children: [
        Observer(builder: (_) {
          final node = nodeSyncStatus.nodes
              .firstWhere((element) => element.nodeInfo.publicKey == publicKey);

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
