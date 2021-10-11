class ServiceNodeStatus {
  ServiceNodeStatus(
      this.active,
      this.contribution,
      this.decommissionCount,
      this.earnedDowntimeBlocks,
      this.funded,
      this.lastReward,
      this._lastUptimeProof,
      this.requestedUnlockHeight,
      this.nodeInfo,
      this.stateHeight,
      this.storageServer,
      this.swarmId,
      {this.stakingRequirement = 15000000000000});

  final bool active;
  final Contribution contribution;
  final ServiceNodeInfo nodeInfo;
  final int decommissionCount;
  final int earnedDowntimeBlocks;
  final bool funded;
  final LastReward lastReward;
  final int stakingRequirement;
  final int stateHeight;
  final StorageServerStatus storageServer;
  final int requestedUnlockHeight;
  final int swarmId;
  final int _lastUptimeProof;

  bool get isUnlocking => requestedUnlockHeight != 0;

  DateTime get lastUptimeProof =>
      DateTime.fromMillisecondsSinceEpoch(_lastUptimeProof * 1000);

  static ServiceNodeStatus load(Map map) {
    final keys = [
      'decommission_count',
      'earned_downtime_blocks',
      'last_reward_block_height',
      'last_reward_transaction_index',
      'last_uptime_proof',
      'registration_height',
      'registration_hf_version',
      'requested_unlock_height',
      'state_height',
      'storage_server_reachable_timestamp',
      'swarm_id',
      'total_contributed',
      'total_reserved'
    ];

    for (final key in keys) {
      try {
        map[key] as int;
      } catch (e) {
        map[key] = (map[key] as double).truncate();
      }
    }

    final contribution = Contribution.fromMap(map);
    final storageServerStatus = StorageServerStatus.fromMap(map);
    final lastReward = LastReward.fromMap(map);
    final serviceNodeInfo = ServiceNodeInfo.fromMap(map);

    return ServiceNodeStatus(
        map['active'] as bool,
        contribution,
        map['decommission_count'] as int,
        map['earned_downtime_blocks'] as int,
        map['funded'] as bool,
        lastReward,
        map['last_uptime_proof'] as int,
        map['requested_unlock_height'] as int,
        serviceNodeInfo,
        map['state_height'] as int,
        storageServerStatus,
        map['swarm_id'] as int);
  }
}

class ServiceNodeInfo {
  ServiceNodeInfo(this.operatorAddress, this.registrationHeight,
      this.registrationHfVersion, this.publicKey, this.ipAddress, this.version);

  ServiceNodeInfo.fromMap(Map map)
      : operatorAddress = map['operator_address'] as String,
        registrationHeight = map['registration_height'] as int,
        registrationHfVersion = map['registration_hf_version'] as int,
        publicKey = map['service_node_pubkey'] as String,
        ipAddress = map['public_ip'] as String,
        version = (map['service_node_version'] as List).join('.');

  final String operatorAddress;
  final int registrationHeight;
  final int registrationHfVersion;
  final String publicKey;
  final String ipAddress;
  final String version;

  bool equals(ServiceNodeInfo serviceNodeInfo) {
    return serviceNodeInfo.operatorAddress == operatorAddress &&
        serviceNodeInfo.registrationHeight == registrationHeight &&
        serviceNodeInfo.registrationHfVersion == registrationHfVersion &&
        serviceNodeInfo.publicKey == publicKey &&
        serviceNodeInfo.ipAddress == ipAddress &&
        serviceNodeInfo.version == version;
  }
}

class StorageServerStatus {
  StorageServerStatus(this.isReachable, this.timestamp);

  StorageServerStatus.fromMap(Map map)
      : isReachable = map['storage_server_reachable'] as bool,
        timestamp = map['storage_server_reachable_timestamp'] as int;

  final bool isReachable;
  final int timestamp;
}

class Contributor {
  Contributor(this.address, this.amount, this.reserved);

  Contributor.fromMap(Map map)
      : address = (map['address'] ?? '') as String,
        amount = (map['amount'] ?? 0) as int,
        reserved = (map['reserved'] ?? 0) as int;

  final String address;
  final int amount;
  final int reserved;
}

class Contribution {
  Contribution(this.contributors, this.totalContributed, this.totalReserved);

  Contribution.fromMap(Map map)
      : totalContributed = (map['total_contributed'] ?? 0) as int,
        totalReserved = (map['total_reserved'] ?? 0) as int,
        contributors = (map['contributors'] as List)
            .map((e) => Contributor.fromMap(e))
            .toList();

  final int totalContributed;
  final int totalReserved;
  final List<Contributor> contributors;
}

class LastReward {
  LastReward(this.blockHeight, this.transactionIndex);

  LastReward.fromMap(Map map)
      : blockHeight = (map['last_reward_block_height'] ?? 0) as int,
        transactionIndex = (map['last_reward_transaction_index'] ?? 0) as int;

  final int blockHeight;
  final int transactionIndex;
}
