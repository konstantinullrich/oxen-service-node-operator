import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/oxen/service_node.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';
import 'package:oxen_service_node/src/widgets/base_page.dart';
import 'package:oxen_service_node/src/widgets/primary_button.dart';
import 'package:oxen_service_node/src/widgets/scollable_with_bottom_section.dart';
import 'package:provider/provider.dart';

class AddNewNodePage extends BasePage {
  @override
  String get title => S.current.add_service_node_title;

  @override
  Widget body(BuildContext context) => AddNewNodePageBody();
}

class AddNewNodePageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddNewNodePageBodyState();
}

class AddNewNodePageBodyState extends State<AddNewNodePageBody> {
  final _nameController = TextEditingController();
  final _publicKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _isValidPublicKey(String publicKey) {
    if (publicKey.length == 64) return 0;
    if (publicKey.length < 64) return -1;
    if (publicKey.length > 64) return 1;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _publicKeyController.dispose();
    super.dispose();
  }

  void _saveServiceNode(Box<ServiceNode> serviceNodeSource) {
    final serviceNode =
        ServiceNode(_nameController.text, _publicKeyController.text);
    serviceNodeSource.add(serviceNode);
  }

  @override
  Widget build(BuildContext context) {
    final serviceNodeSource = Provider.of<Box<ServiceNode>>(context);

    return ScrollableWithBottomSection(
      contentPadding: EdgeInsets.all(0),
      content: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).accentTextTheme.overline.color),
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: 18.0, color: Theme.of(context).hintColor),
                      hintText: S.of(context).name,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: OxenPalette.teal, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).focusColor,
                              width: 1.0)))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).accentTextTheme.overline.color),
                controller: _publicKeyController,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                        fontSize: 18.0, color: Theme.of(context).hintColor),
                    hintText: S.of(context).public_key,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: OxenPalette.teal, width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).focusColor, width: 1.0)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: OxenPalette.red, width: 1.0)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: OxenPalette.red, width: 1.0)),
                    errorStyle: TextStyle(color: OxenPalette.red),
                    suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        color: OxenPalette.teal,
                        icon: Icon(Icons.content_paste_sharp),
                        onPressed: () async {
                          final clipboard = await Clipboard.getData('text/plain');
                          if (clipboard.text != null) _publicKeyController.text = clipboard.text;
                        })),
                validator: (value) {
                  final validPublicKey = _isValidPublicKey(value);
                  if (value.isEmpty || validPublicKey == -1)
                    return S.of(context).error_public_key_too_short;
                  else if (validPublicKey == 1)
                    return S.of(context).error_public_key_too_long;
                  return null;
                },
              ),
            ),
          ]),
        ),
      ),
      bottomSection: PrimaryButton(
          onPressed: () {
            if (!_formKey.currentState.validate()) return;
            _saveServiceNode(serviceNodeSource);
            // Navigator.pushNamed(context, OxenRoutes.dashboard);
          },
          text: S.of(context).add_service_node,
          color: Theme.of(context).primaryTextTheme.button.backgroundColor,
          borderColor:
              Theme.of(context).primaryTextTheme.button.decorationColor),
    );
  }
}
