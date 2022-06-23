import 'package:oxen_service_node/generated/l10n.dart';

class DashboardOrderBy {
  static const NEXT_REWARD = const DashboardOrderBy._('NEXT_REWARD');
  static const LAST_UPTIME_PROOF = const DashboardOrderBy._('LAST_UPTIME_PROOF');
  static const NAME = const DashboardOrderBy._('NAME');

  static get values => [NEXT_REWARD, LAST_UPTIME_PROOF, NAME];

  final String name;

  const DashboardOrderBy._(this.name);

  static DashboardOrderBy parse(String nodeSortOrder) {
    return DashboardOrderBy.values.firstWhere(
        (element) => element.name == nodeSortOrder,
        orElse: () => DashboardOrderBy.NEXT_REWARD);
  }

  @override
  String toString() {
    switch (this) {
      case NEXT_REWARD:
        return S.current.dashboard_order_by_next_reward;
      case LAST_UPTIME_PROOF:
        return S.current.last_uptime_proof;
      case NAME:
        return S.current.dashboard_order_by_name;
    }
    return "";
  }
}
