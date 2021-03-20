import 'package:oxen_service_node/generated/l10n.dart';

extension DateFormatter on DateTime {
  String toHumanString() {
    final months = [
      S.current.month_january,
      S.current.month_february,
      S.current.month_march,
      S.current.month_april,
      S.current.month_may,
      S.current.month_june,
      S.current.month_july,
      S.current.month_august,
      S.current.month_september,
      S.current.month_october,
      S.current.month_november,
      S.current.month_december
    ];
    return '$day. ${months[month - 1]} $year $hour:$minute';
  }
}
