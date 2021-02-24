import 'package:flutter/material.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';

class NavListProgress extends StatelessWidget {
  NavListProgress(this.title, this.value, this.maxValue, {this.threshold = 0});

  final String title;
  final int value;
  final int threshold;
  final int maxValue;

  Color get progressColor =>
      value > threshold ? OxenPalette.lime : OxenPalette.red;

  double get progress => value / maxValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 15.0),
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 15.0, color: Palette.wildDarkBlue),
              ),
              SizedBox(height: 10.0),
              LinearProgressIndicator(
                minHeight: 10.0,
                value: progress,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                backgroundColor: Palette.wildDarkBlue,
              )
            ],
          ),
        )
      ],
    );
  }
}
