import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/stores/settings_store.dart';
import 'package:oxen_service_node/src/utils/dashboard_sort_order.dart';
import 'package:oxen_service_node/src/utils/router/oxen_routes.dart';
import 'package:oxen_service_node/src/utils/theme/theme_changer.dart';
import 'package:oxen_service_node/src/widgets/base_page.dart';
import 'package:oxen_service_node/src/widgets/nav/nav_list_arrow.dart';
import 'package:oxen_service_node/src/widgets/nav/nav_list_header.dart';
import 'package:oxen_service_node/src/widgets/nav/nav_list_trailing.dart';
import 'package:oxen_service_node/src/widgets/present_picker.dart';
import 'package:oxen_service_node/src/widgets/standard_switch.dart';
import 'package:provider/provider.dart';

class SettingsPage extends BasePage {
  @override
  String get title => S.current.title_settings;

  Future<void> _setDashboardOrderBy(BuildContext context) async {
    final settingsStore = context.read<SettingsStore>();
    final selectedDashboardOrderBy =
        await presentPicker(context, DashboardOrderBy.values);

    await settingsStore.setDashboardOrderBy(selectedDashboardOrderBy as DashboardOrderBy);
  }

  @override
  Widget body(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final themeChanger = Provider.of<ThemeChanger>(context);
    settingsStore.themeChanger = themeChanger;

    return Column(
      children: <Widget>[
        NavListHeader(S.of(context).settings_title_general),
        NavListTrailing(
          leading: Icon(Icons.cloud_sharp),
          text: S.of(context).settings_daemon,
          trailing: Observer(builder: (_) {
            return Text(
              settingsStore.daemon!.hostname,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).primaryTextTheme.titleSmall?.color),
            );
          }),
          onTap: () =>
              Navigator.of(context).pushNamed(OxenRoutes.settingsDaemon),
        ),
        NavListArrow(
          leading: Icon(Icons.edit_sharp),
          text: S.of(context).settings_service_nodes,
          onTap: () =>
              Navigator.of(context).pushNamed(OxenRoutes.settingsServiceNode),
        ),
        NavListTrailing(
          leading: Icon(Icons.sort_sharp),
          text: S.of(context).settings_order_by,
          trailing: Observer(builder: (_) {
            return Text(
              settingsStore.dashboardOrderBy.toString(),
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).primaryTextTheme.titleSmall?.color),
            );
          }),
          onTap: () => _setDashboardOrderBy(context),
        ),
        NavListHeader(S.of(context).settings_title_app),
        Observer(builder: (_) {
          return NavListTrailing(
            leading: Icon(Icons.lightbulb_sharp),
            text: settingsStore.isDarkTheme
                ? S.of(context).settings_light_theme
                : S.of(context).settings_dark_theme,
            trailing: StandardSwitch(
              value: settingsStore.isDarkTheme,
              onTaped: () => settingsStore.toggleDarkTheme(),
            ),
          );
        }),
        NavListArrow(
          leading: Icon(Icons.language_sharp),
          text: S.of(context).settings_language,
          onTap: () =>
              Navigator.of(context).pushNamed(OxenRoutes.settingsLanguage),
        ),
        NavListArrow(
          leading: Icon(Icons.change_history_sharp),
          text: S.of(context).title_changelog,
          onTap: () =>
              Navigator.of(context).pushNamed(OxenRoutes.settingsChangelog),
        )
      ],
    );
  }
}
