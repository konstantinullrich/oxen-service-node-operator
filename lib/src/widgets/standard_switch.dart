import 'package:flutter/material.dart';

class StandardSwitch extends StatefulWidget {
  const StandardSwitch({required this.value, required this.onTaped});

  final bool value;
  final VoidCallback onTaped;

  @override
  StandardSwitchState createState() => StandardSwitchState();
}

class StandardSwitchState extends State<StandardSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTaped,
      child: AnimatedContainer(
        padding: EdgeInsets.only(left: 4.0, right: 4.0),
        alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        duration: Duration(milliseconds: 200),
        width: 55.0,
        height: 33.0,
        decoration: BoxDecoration(
            color: Theme.of(context).toggleButtonsTheme.color,
            border: Border.all(
                color: Theme.of(context).toggleButtonsTheme.borderColor!),
            borderRadius: BorderRadius.all(Radius.circular(33.0))),
        child: Container(
          width: 25.0,
          height: 25.0,
          decoration: BoxDecoration(
              color: widget.value
                  ? Theme.of(context).toggleButtonsTheme.selectedColor
                  : Theme.of(context).toggleButtonsTheme.disabledColor,
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          child: Icon(
            widget.value ? Icons.check : Icons.close,
            color: Colors.white,
            size: 16.0,
          ),
        ),
      ),
    );
  }
}
