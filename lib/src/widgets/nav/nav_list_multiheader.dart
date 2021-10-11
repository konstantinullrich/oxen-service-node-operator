import 'package:flutter/material.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';

class NavListMultiHeader extends StatelessWidget {
  NavListMultiHeader(this.title, this.subtitle, {this.onTap});

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  double get subtitleSize => subtitle.length > 30 ? 16.0 : 20.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            SizedBox(height: 15.0),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 15.0, color: Palette.wildDarkBlue),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: subtitleSize,
                        color:
                            Theme.of(context).primaryTextTheme.headline5.color),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
