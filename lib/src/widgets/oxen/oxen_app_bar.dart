import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oxen_service_node/src/utils/theme/theme_changer.dart';
import 'package:oxen_service_node/src/utils/theme/themes.dart';
import 'package:provider/provider.dart';

class OxenAppBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  factory OxenAppBar(
      {required BuildContext context,
      Widget? leading,
      Widget? middle,
      Widget? trailing,
      Color? backgroundColor}) {
    final _themeChanger = Provider.of<ThemeChanger>(context);
    final _isDarkTheme = _themeChanger.theme == Themes.darkTheme;

    return OxenAppBar._internal(
        leading: leading,
        middle: middle,
        trailing: trailing,
        height: _height,
        backgroundColor:
            _isDarkTheme ? Theme.of(context).backgroundColor : backgroundColor);
  }

  factory OxenAppBar.withShadow(
      {required BuildContext context,
      Widget? leading,
      Widget? middle,
      Widget? trailing,
      Color? backgroundColor}) {
    final _themeChanger = Provider.of<ThemeChanger>(context);
    final _isDarkTheme = _themeChanger.theme == Themes.darkTheme;

    return OxenAppBar._internal(
      leading: leading,
      middle: middle,
      trailing: trailing,
      height: 80,
      backgroundColor:
          _isDarkTheme ? Theme.of(context).backgroundColor : backgroundColor,
      decoration: BoxDecoration(
          color: _isDarkTheme
              ? Theme.of(context).backgroundColor
              : backgroundColor,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(132, 141, 198, 0.11),
                blurRadius: 8,
                offset: Offset(0, 2))
          ]),
    );
  }

  OxenAppBar._internal(
      {this.leading,
      this.middle,
      this.trailing,
      this.backgroundColor,
      this.decoration,
      this.height = _height});

  static const _originalHeight = 44.0; // iOS nav bar height
  static const _height = 60.0;

  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;
  final Color? backgroundColor;
  final BoxDecoration? decoration;
  final double height;

  @override
  Widget build(BuildContext context) {
    final pad = height - _originalHeight;
    final paddingTop = pad / 2;
    final _paddingBottom = (pad / 2);

    return Container(
      decoration: decoration ?? BoxDecoration(color: backgroundColor),
      padding:
          EdgeInsetsDirectional.only(bottom: _paddingBottom, top: paddingTop),
      child: CupertinoNavigationBar(
        leading: leading,
        middle: middle,
        trailing: trailing,
        backgroundColor: backgroundColor,
        border: null,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return false;
  }
}
