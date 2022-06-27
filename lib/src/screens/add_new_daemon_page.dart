import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/oxen/daemon.dart';
import 'package:oxen_service_node/src/widgets/base_page.dart';
import 'package:oxen_service_node/src/widgets/oxen/oxen_text_field.dart';
import 'package:oxen_service_node/src/widgets/primary_button.dart';
import 'package:oxen_service_node/src/widgets/scrollable_with_bottom_section.dart';
import 'package:provider/provider.dart';

class AddNewDaemonPage extends BasePage {
  @override
  String get title => S.current.title_add_daemon;

  @override
  Widget body(BuildContext context) => AddNewDaemonPageBody();
}

class AddNewDaemonPageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddNewDaemonPageBodyState();
}

class AddNewDaemonPageBodyState extends State<AddNewDaemonPageBody> {
  final _hostController = TextEditingController();
  final _portController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    super.dispose();
  }

  Future _saveDaemon(Box<Daemon> daemonSource) async {
    var uri = _hostController.text;
    final port = _portController.text;

    if (port != null && port.isNotEmpty) uri = '$uri:$port';

    final daemon = Daemon(uri);
    await daemonSource.add(daemon);
  }

  String _validateNodeAddress(String value) {
    const pattern =
        '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\$|^[-0-9a-zA-Z.]{1,253}\$';
    final isValid = RegExp(pattern).hasMatch(value);
    return isValid ? null : S.current.error_text_daemon_address;
  }

  String _validateNodePort(String value) {
    const pattern = '^[0-9]{1,5}';
    final regExp = RegExp(pattern);
    bool isValid = false;

    if (regExp.hasMatch(value)) {
      try {
        final intValue = int.parse(value);
        isValid = (intValue >= 0 && intValue <= 65535);
      } catch (e) {}
    }

    return isValid ? null : S.current.error_text_daemon_port;
  }

  @override
  Widget build(BuildContext context) {
    final daemonSource = Provider.of<Box<Daemon>>(context);

    return ScrollableWithBottomSection(
      contentPadding: EdgeInsets.all(0),
      content: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: OxenTextField(
                controller: _hostController,
                hintText: S.of(context).daemon_address,
                validator: (value) => _validateNodeAddress(value),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: OxenTextField(
                controller: _portController,
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                hintText: S.of(context).daemon_port,
                validator: (value) => _validateNodePort(value),
              ),
            ),
          ]),
        ),
      ),
      bottomSection: PrimaryButton(
          onPressed: () async {
            if (!_formKey.currentState.validate()) return;
            await _saveDaemon(daemonSource);
            Navigator.of(context).pop();
          },
          text: S.of(context).add_daemon,
          color: Theme.of(context).primaryTextTheme.button.backgroundColor,
          borderColor:
              Theme.of(context).primaryTextTheme.button.decorationColor),
    );
  }
}
