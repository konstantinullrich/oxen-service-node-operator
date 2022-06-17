import 'package:flutter/material.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';

class NavListMultiHeader extends StatelessWidget {
  NavListMultiHeader(this.title, this.subtitle,
      {this.onTap,
      this.forceSmallText = false,
      this.titleColor,
      this.subtitleColor});

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool forceSmallText;
  final Color titleColor;
  final Color subtitleColor;

  Color get _titleColor => titleColor ?? Palette.wildDarkBlue;

  double get subtitleSize =>
      (subtitle.length > 40 || forceSmallText) ? 16.0 : 20.0;

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
                    style: TextStyle(fontSize: 15.0, color: _titleColor),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: subtitleSize,
                        color: subtitleColor ??
                            Theme.of(context).primaryTextTheme.headline5.color),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
