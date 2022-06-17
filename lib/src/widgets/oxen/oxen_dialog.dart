import 'dart:ui';

import 'package:flutter/material.dart';

Future showOxenDialog(BuildContext context, Widget child,
    {void Function(BuildContext context) onDismiss}) {
  return showDialog<void>(
      builder: (_) => OxenDialog(body: child, onDismiss: onDismiss),
      context: context);
}

class OxenDialog extends StatelessWidget {
  OxenDialog({this.body, this.onDismiss});

  final void Function(BuildContext context) onDismiss;
  final Widget body;

  void _onDismiss(BuildContext context) {
    if (onDismiss == null) {
      Navigator.of(context).pop();
    } else {
      onDismiss(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onDismiss(context),
      child: Container(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.55)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: body),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
