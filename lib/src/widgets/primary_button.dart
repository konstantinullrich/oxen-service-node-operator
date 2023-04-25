import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {required this.onPressed,
      required this.text,
      required this.color,
      required this.borderColor,
      this.textColor,
      this.isDisabled = false,
      this.onDisabledPressed});

  final VoidCallback onPressed;
  final VoidCallback? onDisabledPressed;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final String text;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final textColor =
        this.textColor ?? Theme.of(context).primaryTextTheme.labelLarge?.color;

    final borderColor = this.borderColor ?? Theme.of(context).primaryTextTheme.labelLarge?.decorationColor;

    return ButtonTheme(
        minWidth: double.infinity,
        height: 56.0,
        child: TextButton(
          onPressed: isDisabled ? onDisabledPressed : onPressed,
          style: TextButton.styleFrom(
            backgroundColor: isDisabled ? Colors.transparent : color,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: borderColor!),
                borderRadius: BorderRadius.circular(10.0)),
          ),

          child: Text(text,
              style: TextStyle(
                  fontSize: 16.0,
                  color: isDisabled ? Palette.darkGrey : textColor)),
        ));
  }
}
