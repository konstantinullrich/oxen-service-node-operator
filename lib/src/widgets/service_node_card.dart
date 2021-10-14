import 'package:flutter/material.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/utils/router/oxen_routes.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';

class ServiceNodeCard extends StatelessWidget {
  ServiceNodeCard(this.name, this.serviceNodeKey, this.isUnlocking, this.active,
      this.isStorageServerReachable, this.lastRewardBlockHeight);

  final String name;
  final String serviceNodeKey;
  final bool isUnlocking;
  final bool active;
  final bool isStorageServerReachable;
  final int lastRewardBlockHeight;

  @override
  Widget build(BuildContext context) {
    final serviceNodeKeyShort =
        '${serviceNodeKey.substring(0, 12)}...${serviceNodeKey.substring(serviceNodeKey.length - 4)}';
    final statusIcon = isUnlocking
        ? Icon(Icons.access_time_sharp, color: OxenPalette.orange, size: 30)
        : (active
            ? Icon(Icons.check_circle_sharp,
                color: OxenPalette.iceBlue, size: 30)
            : Icon(Icons.error_sharp, color: OxenPalette.red, size: 30));

    return Card(
        child: ExpansionTile(
      leading: Padding(padding: EdgeInsets.all(5), child: statusIcon),
      title: Text(name,
          style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).primaryTextTheme.caption.color)),
      subtitle: Text(serviceNodeKeyShort,
          style: TextStyle(
              color: Theme.of(context).primaryTextTheme.caption.color)),
      children: [
        Row(children: [
          Expanded(
            flex: 1,
            child: Container(
              width: (MediaQuery.of(context).size.width - 1) * 0.25,
              height: 100,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Text('$lastRewardBlockHeight',
                              style: TextStyle(fontSize: 20)),
                        )),
                    Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(S.of(context).last_reward,
                            style: TextStyle(fontSize: 16)))
                  ]),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Icon(
                                isStorageServerReachable
                                    ? Icons.check_circle_sharp
                                    : Icons.error_sharp,
                                size: 30),
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(S.of(context).storage_server,
                              style: TextStyle(fontSize: 16)))
                    ])),
          ),
          Expanded(
            flex: 1,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: 100,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).pushNamed(
                      OxenRoutes.detailsServiceNode,
                      arguments: [serviceNodeKey, name]),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Icon(Icons.info_sharp, size: 30),
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(S.of(context).more,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)))
                      ]),
                )),
          )
        ])
      ],
    ));
  }
}
