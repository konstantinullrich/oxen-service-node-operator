import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/oxen/service_node.dart';
import 'package:oxen_service_node/src/utils/router/oxen_routes.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';
import 'package:oxen_service_node/src/widgets/base_page.dart';
import 'package:provider/provider.dart';

class EditServiceNodesPage extends BasePage {
  @override
  String get title => S.current.title_edit_service_node;

  @override
  Widget trailing(BuildContext context) {
    return SizedBox(
      width: 30,
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () =>
              Navigator.of(context).pushNamed(OxenRoutes.addServiceNode),
          child: Icon(Icons.add_sharp,
              color: Theme.of(context).primaryTextTheme.caption.color,
              size: 24)),
    );
  }

  @override
  Widget body(BuildContext context) {
    final serviceNodeSources = Provider.of<Box<ServiceNode>>(context);

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
                          leading: Icon(CupertinoIcons.chart_bar_circle),
                            title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serviceNode.name,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  .color),
                        ),
                        Text(
                          '${publicKey.substring(0, 16)}...${publicKey.substring(publicKey.length - 5)}',
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .subtitle2
                                  .color),
                        ),
                      ],
                    )));

                    return Dismissible(
                        key: Key('${serviceNode.key}'),
                        onDismissed: (direction) async =>
                            await serviceNodeSources.delete(serviceNode.key),
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
