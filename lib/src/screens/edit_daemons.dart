import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/oxen/daemon.dart';
import 'package:oxen_service_node/src/stores/settings_store.dart';
import 'package:oxen_service_node/src/utils/router/oxen_routes.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';
import 'package:oxen_service_node/src/widgets/base_page.dart';
import 'package:oxen_service_node/src/widgets/node_indicator.dart';
import 'package:provider/provider.dart';

class EditDaemonsPage extends BasePage {
  @override
  String get title => S.current.title_edit_daemons;

  @override
  Widget trailing(BuildContext context) {
    return SizedBox(
      width: 30,
      child: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () =>
              Navigator.of(context).pushNamed(OxenRoutes.addDaemon),
          icon: Icon(Icons.add_sharp,
              color: Theme.of(context).primaryTextTheme.bodySmall?.color,
              size: 24)),
    );
  }

  @override
  Widget body(BuildContext context) {
    final daemonSources = Provider.of<Box<Daemon>>(context);
    final settingsStore = Provider.of<SettingsStore>(context);

    final daemons = daemonSources.values.toList();
    final currentColor = Theme.of(context).selectedRowColor;
    final notCurrentColor = Theme.of(context).colorScheme.background;

    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          Expanded(
              child: ListView.separated(
                  separatorBuilder: (_, __) => Divider(
                      color: Theme.of(context).dividerTheme.color, height: 1),
                  itemCount: daemons.length,
                  itemBuilder: (BuildContext context, int index) {
                    final daemon = daemons[index];

                    return Observer(builder: (_) {
                      final isCurrent = daemon.key == settingsStore.daemon?.key;

                      final content = Container(
                          color: isCurrent ? currentColor : notCurrentColor,
                          child: ListTile(
                            title: Text(
                              daemon.uri,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleLarge
                                      ?.color),
                            ),
                            trailing: FutureBuilder(
                                future: daemon.isOnline(),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.done:
                                      return NodeIndicator(
                                          active: snapshot.data as bool);
                                    default:
                                      return NodeIndicator();
                                  }
                                }),
                            onTap: () async {
                              if (!isCurrent) {
                                await settingsStore.setDaemon(daemon);
                                Navigator.of(context).pop();
                              }
                            },
                          ));

                      return isCurrent
                          ? content
                          : Dismissible(
                              key: Key('${daemon.key}'),
                              onDismissed: (direction) async =>
                                  await daemonSources.delete(daemon.key),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                padding: EdgeInsets.only(right: 10.0),
                                alignment: AlignmentDirectional.centerEnd,
                                color: OxenPalette.red,
                                child: Icon(
                                  CupertinoIcons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: content);
                    });
                  }))
        ],
      ),
    );
  }
}
