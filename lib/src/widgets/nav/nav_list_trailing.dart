import 'package:flutter/material.dart';

class NavListTrailing extends StatelessWidget {
  NavListTrailing({required this.text, this.leading, this.onTap, this.trailing});

  final String text;
  final Widget? leading;
  final Widget? trailing;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
        leading: leading,
        title: Text(text,
            style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).primaryTextTheme.titleLarge?.color)),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
