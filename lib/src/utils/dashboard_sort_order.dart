import 'package:oxen_service_node/generated/l10n.dart';

class DashboardOrderBy {
  static const NEXT_REWARD = const DashboardOrderBy._('NEXT_REWARD');
  static const NAME = const DashboardOrderBy._('NAME');

  static get values => [NEXT_REWARD, NAME];

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
      case NAME:
        return S.current.dashboard_order_by_name;
    }
    return "";
  }
}
