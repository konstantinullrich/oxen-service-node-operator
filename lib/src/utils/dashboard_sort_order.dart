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
}
