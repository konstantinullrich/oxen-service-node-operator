import 'package:oxen_service_node/src/oxen/contributor.dart';

class ServiceNodeStatus {
  ServiceNodeStatus(
      this.active,
      this.contributors,
      this.decommissionCount,
      this.earnedDowntimeBlocks,
      this.funded,
      this.lastRewardBlockHeight,
      this.lastRewardTransactionIndex,
      this.lastUptimeProof,
      this.operatorAddress,
      this.registrationHeight,
      this.registrationHfVersion,
      this.requestedUnlockHeight,
      this.serviceNodePubkey,
      this.serviceNodeVersion,
      this.stateHeight,
      this.storageServerReachable,
      this.storageServerReachableTimestamp,
      this.swarmId,
      this.totalContributed,
      this.totalReserved,
      {this.stakingRequirement = 15000000000000});

  final bool active;
  final List<Contributor> contributors;
  final int decommissionCount;
  final int earnedDowntimeBlocks;
  final bool funded;
  final int lastRewardBlockHeight;
  final int lastRewardTransactionIndex;
  final int lastUptimeProof;
  final String operatorAddress;
  final int registrationHeight;
  final int registrationHfVersion;
  final int requestedUnlockHeight;
  final String serviceNodePubkey;
  final String serviceNodeVersion;
  final int stakingRequirement;
  final int stateHeight;
  final bool storageServerReachable;
  final int storageServerReachableTimestamp;
  final int swarmId;
  final int totalContributed;
  final int totalReserved;

  static ServiceNodeStatus load(Map map) {
    List<Contributor> contributors = (map['contributors'] as List)
        .map((e) => Contributor.fromMap(e))
        .toList();
    return ServiceNodeStatus(
      map['active'] as bool,
      contributors,
      map['decommission_count'] as int,
      map['earned_downtime_blocks'] as int,
      map['funded'] as bool,
      map['last_reward_block_height'] as int,
      map['last_reward_transaction_index'] as int,
      map['last_uptime_proof'] as int,
      map['operator_address'] as String,
      map['registration_height'] as int,
      map['registration_hf_version'] as int,
      map['requested_unlock_height'] as int,
      map['operator_address'] as String,
      (map['service_node_version'] as List).join('.'),
      map['state_height'] as int,
      map['storage_server_reachable'] as bool,
      map['storage_server_reachable_timestamp'] as int,
      map['swarm_id'] as int,
      map['total_contributed'] as int,
      map['total_reserved'] as int,
    );
  }
}
