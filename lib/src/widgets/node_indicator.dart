import 'package:flutter/material.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';

class NodeIndicator extends StatelessWidget {
  NodeIndicator({bool active = false})
      : _color = active ? OxenPalette.green : OxenPalette.red;

  final Color _color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(shape: BoxShape.circle, color: _color),
    );
  }
}
