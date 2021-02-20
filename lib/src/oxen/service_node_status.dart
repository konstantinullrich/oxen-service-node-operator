import 'package:oxen_service_node/src/oxen/contributor.dart';

class ServiceNodeStatus {
  ServiceNodeStatus(this.active,
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
    bool active = map['active'] as bool;
    int decommissionCount = map['decommission_count'] as int;
    int earnedDowntimeBlocks = map['earned_downtime_blocks'] as int;
    bool funded = map['funded'] as bool;
    int lastRewardBlockHeight = map['last_reward_block_height'] as int;
    int lastRewardTransactionIndex = map['last_reward_transaction_index'] as int;
    int lastUptimeProof = map['last_uptime_proof'] as int;
    String operatorAddress = map['operator_address'] as String;
    int registrationHeight = map['registration_height'] as int;
    int registrationHfVersion = map['registration_hf_version'] as int;
    int requestedUnlockHeight = map['requested_unlock_height'] as int;
    String serviceNodePubkey = map['operator_address'] as String;
    String serviceNodeVersion = (map['service_node_version'] as List).join('.');
    int stateHeight = map['state_height'] as int;
    bool storageServerReachable = map['storage_server_reachable'] as bool;
    int storageServerReachableTimestamp = map['storage_server_reachable_timestamp'] as int;
    int swarmId = map['swarm_id'] as int;
    int totalContributed = map['total_contributed'] as int;
    int totalReserved = map['total_reserved'] as int;
    List<Contributor> contributors = (map['contributors'] as List).map((e) =>
        Contributor.fromMap(e)).toList();
    return ServiceNodeStatus(
        active,
        contributors,
        decommissionCount,
        earnedDowntimeBlocks,
        funded,
        lastRewardBlockHeight,
        lastRewardTransactionIndex,
        lastUptimeProof,
        operatorAddress,
        registrationHeight,
        registrationHfVersion,
        requestedUnlockHeight,
        serviceNodePubkey,
        serviceNodeVersion,
        stateHeight,
        storageServerReachable,
        storageServerReachableTimestamp,
        swarmId,
        totalContributed,
        totalReserved);
  }
}
