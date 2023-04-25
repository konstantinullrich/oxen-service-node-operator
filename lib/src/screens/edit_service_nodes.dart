import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/oxen/service_node.dart';
import 'package:oxen_service_node/src/stores/node_sync_store.dart';
import 'package:oxen_service_node/src/utils/router/oxen_routes.dart';
import 'package:oxen_service_node/src/utils/short_address.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';
import 'package:oxen_service_node/src/widgets/base_page.dart';
import 'package:provider/provider.dart';

class EditServiceNodesPage extends BasePage {
  @override
  String get title => S.current.title_edit_service_nodes;

  @override
  Widget trailing(BuildContext context) {
    return SizedBox(
      width: 30,
      child: MaterialButton(
          padding: EdgeInsets.all(0),
          onPressed: () =>
              Navigator.of(context).pushNamed(OxenRoutes.addServiceNode),
          child: Icon(Icons.add_sharp,
              color: Theme.of(context).primaryTextTheme.bodySmall?.color,
              size: 24)),
    );
  }

  @override
  Widget body(BuildContext context) => EditServiceNodesPageBody();
}

class EditServiceNodesPageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditServiceNodesPageBodyState();
}

class EditServiceNodesPageBodyState extends State<EditServiceNodesPageBody> {
  @override
  Widget build(BuildContext context) {
    final serviceNodeSources = context.watch<Box<ServiceNode>>();
    final nodeSyncStore = context.watch<NodeSyncStore>();

    final serviceNodes = serviceNodeSources.values.toList();

    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          Expanded(
              child: ListView.separated(
                  separatorBuilder: (_, __) => Divider(
                      color: Theme.of(context).dividerTheme.color, height: 1),
                  itemCount: serviceNodes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final serviceNode = serviceNodes[index];
                    final publicKey = serviceNode.publicKey;

                    final content = Container(
                        child: ListTile(
                      leading: Icon(CupertinoIcons.chart_bar_fill),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            serviceNode.name,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleLarge
                                    ?.color),
                          ),
                          Text(publicKey.toShortAddress(16),
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleSmall
                                    ?.color),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, OxenRoutes.editServiceNode,
                                arguments: publicKey)
                            .whenComplete(() => setState(() {}));
                      },
                    ));

                    return Dismissible(
                        key: Key('${serviceNode.key}'),
                        onDismissed: (direction) async {
                          await serviceNodeSources.delete(serviceNode.key);

                          if (serviceNodeSources.isEmpty)
                            Navigator.pushNamedAndRemoveUntil(context, OxenRoutes.welcome,
                                ModalRoute.withName(OxenRoutes.dashboard));
                          else
                            await nodeSyncStore.sync();
                        },
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
                  }))
        ],
      ),
    );
  }
}
